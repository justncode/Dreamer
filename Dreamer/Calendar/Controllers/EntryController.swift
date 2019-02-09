//
//  EntryController.swift
//  Dreamer
//
//  Created by Justin Rose on 5/13/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit
import StoreKit

class EntryController: UIViewController {
    var entryStore: EntryStore!
    var bodyBottomConstraint: NSLayoutConstraint?
    
    var date: (day: Int, month: Int, year: Int)? {
        didSet {
            guard let date = date else { return }
            navigationItem.title = "\(Month.Name.of(date.month)) \(date.day + 1), \(date.year)"
        }
    }
    
    var entry: Entry? {
        didSet {
            guard let entry = entry else { deleteButton.isEnabled = false; return }
            titleField.text = entry.title
            bodyView.text = entry.body
            placeholderLabel.isHidden = !bodyView.text.isEmpty
            
            if let edited = entry.edited {
                let todayFormat = "Today, \(edited.format("h:mm a"))"
                let pastFormat = edited.format("MMM d, h:mm a")
                dateView.dateLabel.text = "edited \(edited.day == Date().day ? todayFormat : pastFormat)"
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupNotificationObservers()
        self.hideKeyboardWhenTapped()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setSaveButtonState()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        Gradient.updateFrame(to: bodyContainerView.bounds)
    }
    
    private func createEntry() {
        guard let title = titleField.text,
            let date = date else { return }
        
        let timelessDate = CoreDataManager.shared.createTimelessDate(day: date.day, month: date.month, year: date.year)
        
        if let entry = CoreDataManager.shared.createEntry(title: title, body: bodyView.text, date: timelessDate, edited: Date()) {
            entryStore.add(entry)
        }
        navigationController?.popViewController(animated: true)
        
        if CoreDataManager.shared.fetchEntries().count % 5 == 0 {
            SKStoreReviewController.requestReview()
        }
    }
    
    private func saveEntry() {
        guard let title = titleField.text else { return }
        
        entry?.title = title
        entry?.body = bodyView.text
        entry?.edited = Date()
        
        
        if let entry = entry, let index = entryStore.entries.index(of: entry) {
            entryStore.update(entry, at: index)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    private func setSaveButtonState() {
        saveButton.isEnabled = bodyView.hasText && titleField.hasText
    }
    
    @objc private func titleFieldDidChange(_ sender: UITextField) {
        setSaveButtonState()
    }
    
    @objc private func submitEntry() {
        entry == nil ? createEntry() : saveEntry()
    }
    
    @objc private func deleteEntry() {
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            guard let entry = self?.entry else { return }
            self?.entryStore.delete(entry) {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        present(Alert.controller(title: "Delete Dream",
                                 message: "Would you like to delete this dream forever?",
                                 style: .alert,
                                 actions: [deleteAction, UIAlertAction(title: "No", style: .cancel)]),
                animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        bodyBottomConstraint?.constant = -keyboardSize.cgRectValue.height
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bodyBottomConstraint?.constant = 0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // MARK: - Interface Setup
    private func setupViews() {
        navigationItem.rightBarButtonItems = [saveButton, deleteButton]
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        Gradient.mask(colors:  [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)], locations: [0, 0.215, 0.75, 1], to: bodyContainerView)
        
        view.addSubview(dateView)
        dateView.anchor(top: (anchor: view.safeAreaLayoutGuide.topAnchor, constant: 0),
                        leading: (anchor: view.leadingAnchor, constant: 3),
                        trailing: (anchor: view.trailingAnchor, constant: -3))
        dateView.heightAnchor.constraint(equalToConstant: 22.0).isActive = true
        
        view.addSubview(separatorView)
        separatorView.anchor(top: dateView.bottomAnchor, leading: view.leadingAnchor, trailing:  view.trailingAnchor)
        separatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        view.addSubview(titleField)
        titleField.anchor(top: (anchor: separatorView.bottomAnchor, constant: 16))
        titleField.centerX(to: separatorView.centerXAnchor)
        titleField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        titleField.widthAnchor.constraint(equalTo: separatorView.widthAnchor, multiplier: 0.85).isActive = true
        
        view.addSubview(bodyContainerView)
        bodyContainerView.anchor(top: separatorView.bottomAnchor, leading: titleField.leadingAnchor, bottom: view.bottomAnchor, trailing: titleField.trailingAnchor)
        
        bodyView.textContainerInset = UIEdgeInsets(top: view.bounds.height * 0.1 + 24, left: 0, bottom: 0, right: 0)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: view.bounds.height * 0.1 + 18 + ((bodyView.font?.pointSize ?? 16) / 2))
        bodyView.contentOffset = .zero
        bodyContainerView.addSubview(bodyView)
        bodyBottomConstraint = bodyView.bottomAnchor.constraint(equalTo: bodyContainerView.bottomAnchor)
        bodyBottomConstraint!.isActive = true
        bodyView.anchor(top: bodyContainerView.topAnchor, leading: bodyContainerView.leadingAnchor, trailing: bodyContainerView.trailingAnchor)
        
        bodyView.addSubview(placeholderLabel)
        view.sendSubview(toBack: bodyContainerView)
    }
    
    let dateView = DateView()
    let separatorView = SeparatorView()
    let bodyContainerView = UIView()
    
    lazy var saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(submitEntry))
    lazy var deleteButton = UIBarButtonItem(image: #imageLiteral(resourceName: "erase"), style: .plain, target: self, action: #selector(deleteEntry))
    lazy var placeholderLabel: UILabel = {
        let label = UILabel(text: "How was your dream?", textColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.25), font: .systemFont(ofSize: 14))
        label.sizeToFit()
        return label
    }()
    
    let titleField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.boldSystemFont(ofSize: 22)
        textField.attributedPlaceholder = NSAttributedString(string: "Dream Title", attributes: [NSAttributedStringKey.foregroundColor:#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.25)])
        textField.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.75)
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.addTarget(self, action: #selector(titleFieldDidChange), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var bodyView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.showsVerticalScrollIndicator = false
        textView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        textView.textColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5)
        textView.keyboardAppearance = .dark
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
}

// MARK: - UITextViewDelegate
extension EntryController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = textView.hasText
        saveButton.isEnabled = textView.hasText && titleField.hasText
    }
}
