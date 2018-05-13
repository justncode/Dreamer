//
//  DateView.swift
//  Dreamer
//
//  Created by Justin Rose on 5/11/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class DateView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        addSubview(dateLabel)
        dateLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    let dateLabel = UILabel(text: nil, textColor: #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.25), font: .systemFont(ofSize: 12), textAlignment: .center)
}
