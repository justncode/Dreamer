//
//  WeekdayView.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class WeekdayView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interface Elements
    func setupViews() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    let stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: (0..<7).map { i in
            return UILabel(text: Weekday.abbreviation(of: i), textColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5), font: .systemFont(ofSize: 12), textAlignment: .center)
        })
        sv.axis = .horizontal
        sv.distribution = .fillEqually
        sv.alignment = .fill
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
}
