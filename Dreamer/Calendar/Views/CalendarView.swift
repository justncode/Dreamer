//
//  CalendarView.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class CalendarView: UIView {
    
    var onSelection: ((Int, Int, Int) -> Void)?
    var entryStore: EntryStore!
    
    var date = Date() {
        didSet {
            month = date.month
            year = date.year
            offset = Date.weekday(of: Date.date(from: month, year: year))
            days = Date.days(in: month, year: year)
            collectionView.reloadData()
        }
    }
    
    private var month = Calendar.current.component(.month, from: Date())
    private var year = Calendar.current.component(.year, from: Date())
    private lazy var offset = Date.weekday(of: Date.date(from: month, year: year))
    private lazy var days = Date.days(in: month, year: year)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Interface Setup
    private func setupViews() {
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        
        addSubview(collectionView)
        collectionView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.register(DayCell.self, forCellWithReuseIdentifier: "cell")
        cv.isScrollEnabled = false
        cv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        cv.allowsMultipleSelection = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
}

// MARK: - UICollectionViewFlowLayout
extension CalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 7 - 8, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = indexPath.item - offset
        let date = (day: day, month: month, year: year)
        onSelection?(date.day, date.month, date.year)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let today = Date()
        let day = indexPath.item - offset
        return today.month == month && today.year == year && today.day < day + 1 ? false : true
    }
}

// MARK: - UICollectionViewDataSource
extension CalendarView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days + offset
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DayCell
        
        if 0..<offset ~= indexPath.item {
            cell.isHidden = true
            return cell
        }
        
        cell.isHidden = false
        cell.date = (indexPath.item - offset, month, year)
        cell.entry = entryStore.entry(for: (day: indexPath.item - offset, month: month, year: year))
        return cell
    }
}
