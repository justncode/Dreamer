//
//  DayCell.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class DayCell: UICollectionViewCell {
    var entry: Entry? {
        didSet {
            guard let entry = entry,
                let body = entry.body else { dotView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0); return }
            
            let words: CGFloat = CGFloat(Array(body.split(separator: " ")).count)
            let scale: CGFloat = words > 500 ? 1 : words < 50 ? 0.1 : words / 500 /* Floating-point number between 0.0 and 1.0 */
            dotView.transform = CGAffineTransform(scaleX: scale, y: scale)
            dotView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    
    var date: (day: Int, month: Int, year: Int)? {
        didSet {
            guard var day = date?.day, let month = date?.month,  let year = date?.year else { return }
            
            let today = Date()
            day += 1
            dayLabel.textColor = !(today.day == day && today.month == month && today.year == year) ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3) : #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            dayLabel.textColor = today.month == month && today.year == year && today.day < day ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.08) : dayLabel.textColor
            dayLabel.text = String(day)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dotView.round(cornerRadius: dotView.bounds.height / 2)
    }
    
    // MARK: - Interface Setup
    private func setupViews() {
        addSubview(dayLabel)
        dayLabel.center()
        
        addSubview(dotView)
        dotView.translatesAutoresizingMaskIntoConstraints = false
        dotView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dotView.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 4).isActive = true
        dotView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        dotView.widthAnchor.constraint(equalTo: dotView.heightAnchor).isActive = true
    }
    
    let dotView = UIView(backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
    let dayLabel = UILabel(text: "0", textColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.3), font: .systemFont(ofSize: 12), textAlignment: .center)
}

