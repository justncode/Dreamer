//
//  EntriesController.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class EntriesController: UIViewController {
    
    var entryStore: EntryStore!
    lazy var filteredEntries = entryStore.entries
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        navigationController?.delegate = self
        setupNotificationObserver()
        self.hideKeyboardWhenTapped()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Gradient.updateFrame(to: entriesContainerView.bounds)
    }
    
    // MARK: - Navigation Bar Button
    @objc private func showDailyEntry() {
        let today = Date()
        showEntry(for: today.day-1, month: today.month, year: today.year)
    }
    
    private func showEntry(for day: Int, month: Int, year: Int) {
        let entryController = EntryController()
        let entry = entryStore.entry(for: (day: day, month: month, year: year))
        
        entryController.entryStore = entryStore
        entryController.entry = entry
        entryController.date = (day, month, year)
        
        navigationController?.pushViewController(entryController, animated: true)
    }
    
    @objc private func reloadEntries(notification: NSNotification) {
        filteredEntries = entryStore.entries
        tableView.reloadData()
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadEntries), name: .entriesUpdated, object: nil)
    }
    
    // MARK: - Interface Setup
    private func setupViews() {
        setupNavigationBar()
        setupTableView()
        setupView()
        
        view.addSubview(dotView)
        dotView.anchor(top: (anchor: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                       leading: (anchor: view.leadingAnchor, constant: 26),
                       trailing: (anchor: view.trailingAnchor, constant: -26))
        dotView.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        
        view.addSubview(separatorView)
        separatorView.anchor(top: dotView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(entriesContainerView)
        entriesContainerView.anchor(top: separatorView.bottomAnchor, leading: separatorView.leadingAnchor, bottom: view.bottomAnchor, trailing: separatorView.trailingAnchor)
        
        entriesContainerView.addSubview(tableView)
        tableView.anchor(top: entriesContainerView.topAnchor, leading: entriesContainerView.leadingAnchor, bottom: entriesContainerView.bottomAnchor, trailing: entriesContainerView.trailingAnchor)
        
        view.addSubview(searchBarContainer)
        searchBarContainer.anchor(top: separatorView.bottomAnchor, leading: separatorView.leadingAnchor, trailing: separatorView.trailingAnchor)
        searchBarContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        
        searchBarContainer.addSubview(searchBar)
        searchBar.center()
        searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85).isActive = true
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Dreamer"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showDailyEntry))
    }
    
    private func setupTableView() {
        tableView.register(EntryCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
    }
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        Gradient.mask(colors:  [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)], locations: [0, 0.215, 0.75, 1], to: entriesContainerView)
    }
    
    let dotView = DotView()
    let searchBarContainer = UIView()
    let entriesContainerView = UIView()
    let separatorView = SeparatorView()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        tv.delegate = self
        tv.dataSource = self
        tv.contentInset = UIEdgeInsets(top: view.bounds.height * 0.15 - 8, left: 0, bottom: 0, right: 0)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.backgroundImage = UIImage()
        sb.barStyle = .blackOpaque
        sb.placeholder = "Search your dreams..."
        sb.delegate = self
        sb.keyboardAppearance = .dark
        return sb
    }()
}

// MARK: - UISearchBarDelegate
extension EntriesController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredEntries = entryStore.entries
            tableView.reloadData()
            return
        }
        
        filteredEntries = entryStore.entries.filter { entry in
            guard let title = entry.title, let body = entry.body else { return false }
            return title.lowercased().contains(searchText.lowercased()) || body.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension EntriesController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! EntryCell
        cell.entry = filteredEntries[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension EntriesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entryController = EntryController()
        
        let entry = filteredEntries[indexPath.row]
        entryController.entryStore = self.entryStore
        entryController.entry = entry
        
        if let date = entry.date {
            entryController.date = (Int(date.day), Int(date.month), Int(date.year))
        }
        
        self.navigationController?.pushViewController(entryController, animated: true)
    }
}

// MARK: - UINavigationControllerDelegate
extension EntriesController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NavigationAnimator(operation)
    }
}
