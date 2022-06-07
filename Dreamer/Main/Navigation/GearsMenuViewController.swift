//
//  GearsMenuViewController.swift
//  Dreamer
//
//  Created by Conner Maddalozzo on 6/4/22.
//  Copyright © 2022 justncode LLC. All rights reserved.
//

import UIKit


struct CalenderGearsGroupItem {
    var title: String
    var icon: UIImage
    var action: ((Date)->Void)?
}



class GearsMenuViewController: UIViewController {
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    var delegate: UINavigationController?
    public var backdrop: CAGradientLayer = {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(named: "twilight-0")!,
            UIColor(named: "twilight-3")!,
            UIColor(named: "twilight-4")!,
            UIColor(named: "twilight-4")!,
            UIColor(named: "twilight-3")!,
//            UIColor(named: "twilight-2")!,
//            UIColor(named: "twilight-1")!,
            UIColor(named: "twilight-0")!].map {$0.cgColor}
        gradientLayer.opacity = 0.35
        return gradientLayer
    }()
    public var viewmodel = NavigatorCardTableViewViewModel()
    private var actionIcons: [CalenderGearsGroupItem] = []
    public var showEntry: ((Int,Int,Int)->Void)?
    
    convenience init(with actionButtons: [CalenderGearsGroupItem]) {
        self.init(nibName:nil, bundle:nil)
        self.actionIcons = actionButtons
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
        addGrid()
        view.layer.addSublayer(backdrop)
        backdrop.frame = view.bounds
        
   }
    
    override func viewDidLayoutSubviews() {
        if !hasSetPointOrigin {
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
        }
    }
    
    fileprivate func addGrid() {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.distribution = .fillEqually
        hstack.spacing = 15
        hstack.translatesAutoresizingMaskIntoConstraints = false
        hstack.layer.zPosition = 25
        
        view.addSubview(hstack)
        NSLayoutConstraint.activate([
            hstack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: view.layoutMargins.left),
            hstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            hstack.heightAnchor.constraint(equalToConstant: 350)
        ])
        #if targetEnvironment(macCatalyst)
            hstack.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width*2.0/3.0)).isActive = true
            hstack.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width*2.0/3.0)).isActive = true
            hstack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        #else
            if UIDevice.current.model == "iPad" {
                hstack.widthAnchor.constraint(equalToConstant: CGFloat(UIScreen.main.bounds.width*2.0/3.0)).isActive = true
//                hstack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
              }else{
                  hstack.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
              }
        #endif
        
        addTableForm(superView: hstack)
    }
    
    fileprivate func addTableForm(superView: UIStackView) {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(IconedStyledCard.self, forCellReuseIdentifier: String(describing: IconedStyledCard.self))
        superView.addArrangedSubview(tableView)
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = viewmodel
    }

    
    // MARK: - ib outlets
    
    @IBAction private func buttonWasTapped(_ sender: UITapGestureRecognizer) {
        guard let target = sender.view else {return}
        let item = actionIcons[target.tag]
        item.action?(Date())
    }

    @IBAction private func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
        guard let pointOrigin = pointOrigin else {
            return
        }

        let translation = sender.translation(in: view)
        
        // Not allowing the user to drag the view upward
        guard translation.y >= 0 else { return }
        
        // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
        view.frame.origin = CGPoint(x: 0, y: pointOrigin.y + translation.y)
        
        if sender.state == .ended {
            let dragVelocity = sender.velocity(in: view)
            if dragVelocity.y >= 1300 {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Set back to original position of the view controller
                UIView.animate(withDuration: 0.3) {
                    self.view.frame.origin = pointOrigin
                }
            }
        }
    }
}


extension GearsMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            case 0:
                let today = Date()
                showEntry?(today.day-1, today.month, today.year)
            case 1:
                guard let cell = tableView.cellForRow(at: indexPath) as? IconedStyledCard else {return}
                let today = cell.datePicker.date
                showEntry?(today.day-1, today.month, today.year)
                self.dismiss(animated: true) // have to dismiss calendar picker lol then dismiss popover sheet
            default:
            let vc = TagSuggestionBrowser()
            delegate?.pushViewController(vc, animated: true)
        }
        self.dismiss(animated: true)
    }
}
