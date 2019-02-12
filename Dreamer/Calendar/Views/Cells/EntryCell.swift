//
//  EntryCell.swift
//  Dreamer
//
//  Created by Justin Rose on 5/13/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
    
    var entry: Entry? {
        didSet {
            titleLabel.text = entry?.title
            bodyLabel.text = entry?.body
            
            if let date = entry?.date {
                dayLabel.text = String(date.day + 1)
                monthLabel.text = String(Month.Name.of(Int(date.month)).prefix(3).uppercased())
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.round(cornerRadius: 10)
    }
    
    // MARK: - Interface Setup
    private func setupViews() {
        setupCell()
        
        addSubview(containerView)
        containerView.anchor(top: (anchor: topAnchor, constant: 8),
                             leading: (anchor: leadingAnchor, constant: 32),
                             bottom: (anchor: bottomAnchor, constant: -8),
                             trailing: (anchor: trailingAnchor, constant: -32))
        
        containerView.addSubview(leftContainerView)
        leftContainerView.anchor(top: containerView.topAnchor, leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor)
        leftContainerView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.25).isActive = true
        
        dateView.addSubview(dayLabel)
        dayLabel.centerWithConstant(y: -8)
        
        dateView.addSubview(monthLabel)
        monthLabel.centerX(to: dayLabel.centerXAnchor)
        monthLabel.anchor(top: dayLabel.bottomAnchor)
        
        leftContainerView.addSubview(dateView)
        dateView.anchor(top: leftContainerView.topAnchor, leading: leftContainerView.leadingAnchor, bottom: leftContainerView.bottomAnchor, trailing: leftContainerView.trailingAnchor)
        
        containerView.addSubview(rightContainerView)
        rightContainerView.anchor(top: containerView.topAnchor, leading: leftContainerView.trailingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
        
        rightContainerView.addSubview(titleLabel)
        titleLabel.anchor(top: (anchor: rightContainerView.topAnchor, constant: 0),
                          leading: (anchor: rightContainerView.leadingAnchor, constant: 16),
                          bottom: (anchor: rightContainerView.bottomAnchor, constant: -bounds.height / 2),
                          trailing: (anchor: rightContainerView.trailingAnchor, constant: -16))
        
        rightContainerView.addSubview(bodyLabel)
        bodyLabel.anchor(leading: titleLabel.leadingAnchor, trailing: titleLabel.trailingAnchor)
        bodyLabel.anchor(top: (anchor: titleLabel.centerYAnchor, constant: 12), bottom: (anchor: rightContainerView.bottomAnchor, constant: -8))
        
        titleLabel.addSubview(quoteLabel)
        quoteLabel.anchor(top: titleLabel.topAnchor, leading: titleLabel.leadingAnchor, bottom: titleLabel.centerYAnchor, trailing: titleLabel.trailingAnchor)
    }
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    let containerView = UIView(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15))
    let leftContainerView = UIView(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
    let dateView = UIView(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
    let moodView = UIView(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
    let rightContainerView = UIView(backgroundColor: #colorLiteral(red: 0.9305578581, green: 0.9305578581, blue: 0.9305578581, alpha: 0.5))
    
    let dayLabel = UILabel(text: "12", textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: .boldSystemFont(ofSize: 28))
    let monthLabel = UILabel(text: "APR", textColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), font: .systemFont(ofSize: 12))
    let titleLabel = UILabel(text: "Lorem Ipsum", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), font: .boldSystemFont(ofSize: 16))
    let bodyLabel = UILabel(text: "Lorem Ipsum", textColor: #colorLiteral(red: 0.322783404, green: 0.3480841599, blue: 0.3830818966, alpha: 1), font: .systemFont(ofSize: 12), numberOfLines: 0)
    let quoteLabel = UILabel(text: "\"", textColor: #colorLiteral(red: 0.1843843587, green: 0.1982275739, blue: 0.2196825265, alpha: 1), font: .boldSystemFont(ofSize: 32))
}
