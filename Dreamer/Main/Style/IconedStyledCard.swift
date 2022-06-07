//
//  IconedStyledCard.swift
//  Dreamer
//
//  Created by Conner Maddalozzo on 6/5/22.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class IconedStyledCard: UITableViewCell {
    
    public var entry: NavigationCellDatasource? {
        willSet {
            guard let newValue = newValue else {return}
            titleLabel.text = newValue.title
            bodyLabel.text = newValue.body
            icon.image = newValue.img
        }
    }
    public var datePickerOverride: Bool = false {
        didSet {
            bodyLabel.isHidden = datePickerOverride
            datePicker.isHidden = !datePickerOverride
        }
    }
    
    public var dateHandler: ((Date)->Void)?
    
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
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        dateHandler?(sender.date)
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
        
        icon.JNCStyled()
        dateView.addArrangedSubview(icon)
        
        leftContainerView.addSubview(dateView)
        dateView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateView.topAnchor.constraint(equalTo: leftContainerView.topAnchor, constant: 10),
            dateView.bottomAnchor.constraint(equalTo: leftContainerView.bottomAnchor, constant: -10),
            dateView.trailingAnchor.constraint(equalTo: leftContainerView.trailingAnchor, constant: -10),
            dateView.leadingAnchor.constraint(equalTo: leftContainerView.leadingAnchor, constant: 10)
            ])
        
        containerView.addSubview(rightContainerView)
        rightContainerView.anchor(top: containerView.topAnchor, leading: leftContainerView.trailingAnchor, bottom: containerView.bottomAnchor, trailing: containerView.trailingAnchor)
        
        rightContainerView.addSubview(titleLabel)
        titleLabel.anchor(top: (anchor: rightContainerView.topAnchor, constant: 0),
                          leading: (anchor: rightContainerView.leadingAnchor, constant: 16),
                          bottom: (anchor: rightContainerView.bottomAnchor, constant: -bounds.height / 2),
                          trailing: (anchor: rightContainerView.trailingAnchor, constant: -16))
        
        rightContainerView.addSubview(bodyLabel)
        rightContainerView.addSubview(datePicker)
        bodyLabel.anchor(leading: titleLabel.leadingAnchor, trailing: titleLabel.trailingAnchor)
        bodyLabel.anchor(top: (anchor: titleLabel.centerYAnchor, constant: 12), bottom: (anchor: rightContainerView.bottomAnchor, constant: -8))
        
        
        datePicker.anchor(leading: titleLabel.leadingAnchor, trailing: titleLabel.trailingAnchor)
        datePicker.anchor(top: (anchor: titleLabel.centerYAnchor, constant: 12), bottom: (anchor: rightContainerView.bottomAnchor, constant: -8))
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .editingDidEnd)
        datePicker.isHidden = true
        titleLabel.addSubview(quoteLabel)
        quoteLabel.anchor(top: titleLabel.topAnchor, leading: titleLabel.leadingAnchor, bottom: titleLabel.centerYAnchor, trailing: titleLabel.trailingAnchor)
    }
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
    }
    
    let containerView = UIView(backgroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.15))
    let dateView: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.contentMode = .center
        return sv
    }()
    let moodView = UIView(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
    let leftContainerView = UIView(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))
    let rightContainerView = UIView(backgroundColor: #colorLiteral(red: 0.9305578581, green: 0.9305578581, blue: 0.9305578581, alpha: 0.5))
    
    let icon = UIImageView()
    let titleLabel = UILabel(text: "Lorem Ipsum", textColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), font: .boldSystemFont(ofSize: 16))
    let bodyLabel = UILabel(text: "Lorem Ipsum", textColor: #colorLiteral(red: 0.322783404, green: 0.3480841599, blue: 0.3830818966, alpha: 1), font: .systemFont(ofSize: 12), numberOfLines: 0)
    let quoteLabel = UILabel(text: "\''", textColor: #colorLiteral(red: 0.1843843587, green: 0.1982275739, blue: 0.2196825265, alpha: 1), font: .boldSystemFont(ofSize: 32))
    
    let datePicker: UIDatePicker = {
      let picker = UIDatePicker()
        picker.datePickerMode = .date
        return picker
    }()
    
    let dateTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "05/09/22"
        return tf
    }()
}
