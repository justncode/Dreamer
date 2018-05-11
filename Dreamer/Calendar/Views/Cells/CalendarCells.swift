//
//  CalendarCells.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class CalendarCell: UITableViewCell {
    
    var dateSelected: ((Int, Int, Int) -> Void)?
    
    var month: Int? {
        didSet {
            guard let month = month else { return }
            
            var components = DateComponents()
            components.setValue(-month, for: .month)
            
            let date = Calendar.current.date(byAdding: components, to: Date()) ?? Date()
            calendarView.date = date
            
            let name = String(Month.Name.of(date.month))
            let year = String(date.year)
            
            mutableString = NSMutableAttributedString(string: "\(name) \(year)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20)])
            mutableString.addAttribute(NSAttributedStringKey.font, value: UIFont.systemFont(ofSize: 14.5), range: NSRange(location: name.count + 1, length: year.count))
            
            monthLabel.attributedText = mutableString //"\(Month.name(of: date.month)), \(date.year)"
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interface Setup
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        selectionStyle = .none
        
        addSubview(containerView)
        containerView.anchor(top: topAnchor, bottom: bottomAnchor)
        containerView.anchor(leading: (anchor: leadingAnchor, constant: 32), trailing: (anchor: trailingAnchor, constant: -32))
        
        containerView.addSubview(monthLabel)
        monthLabel.anchor(top: (anchor: containerView.topAnchor, constant: 16),
                          leading: (anchor: containerView.leadingAnchor, constant: 12),
                          trailing: (anchor: containerView.trailingAnchor, constant: -12))
        
        containerView.addSubview(calendarView)
        calendarView.anchor(top: (anchor: monthLabel.bottomAnchor, constant: 8))
        calendarView.anchor(leading: containerView.leadingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
    }
    
    let containerView = UIView()
    var mutableString = NSMutableAttributedString()
    let monthLabel = UILabel(textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3), font: .systemFont(ofSize: 18))
    
    lazy var calendarView: CalendarView = {
        let cv = CalendarView()
        cv.onSelection = { [weak self] (day, month, year) in
            self?.dateSelected?(day, month, year)
        }
        return cv
    }()
}
