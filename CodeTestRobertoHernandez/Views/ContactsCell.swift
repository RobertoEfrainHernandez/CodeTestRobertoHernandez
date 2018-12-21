//
//  ContactsCell.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import ChameleonFramework

class ContactsCell: UITableViewCell {
    
    fileprivate let padding: CGFloat = 16
    fileprivate let spacing: CGFloat = 8
    let containerView = ContainerView()
    fileprivate let innerView = UIView()
    fileprivate let gradient = CAGradientLayer()
    
    fileprivate let phoneImageView: UIImageView = {
        let iv = IconImageView(size: 20)
        iv.image = UIImage(named: "Phone")!
        return iv
    }()
    
    fileprivate let emailImageView: UIImageView = {
        let iv = IconImageView(size: 20)
        iv.image = UIImage(named: "Mail")!
        return iv
    }()
    
    fileprivate let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        return label
    }()
    
    fileprivate let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    fileprivate let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var phoneStack = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel])
    lazy var emailStack = UIStackView(arrangedSubviews: [emailImageView, emailLabel])
    
    var contact: Contact? {
        didSet {
            let name = contact?.name ?? "John Doe"
            let phone = contact?.phoneNums.first?.phoneNumber ?? "No phone number"
            let email = contact?.emails.first?.email ?? "No emails"
            let color = UIColor(hexString: contact?.color ?? "008B8B")!
            let contrast = ContrastColorOf(color, returnFlat: true)
            insertGradient(color, contrast)
            nameLabel.text = name
            phoneLabel.text = phone
            emailLabel.text = email
            
            nameLabel.textColor = contrast
            phoneLabel.textColor = contrast
            emailLabel.textColor = contrast
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setLayout()
    }
    
    fileprivate func setLayout() {
        innerView.layer.cornerRadius = 12
        innerView.clipsToBounds = true
        addSubview(containerView)
        containerView.fillSuperview(padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        containerView.addSubview(innerView)
        innerView.fillSuperview()
        
        let mainStack = UIStackView(arrangedSubviews: [nameLabel, phoneStack, emailStack])
        mainStack.axis = .vertical
        [mainStack, phoneStack, emailStack].forEach({ $0.spacing = spacing })
        
        innerView.addSubview(mainStack)
        mainStack.fillSuperview(padding: .init(top: padding * 2, left: padding * 2, bottom: padding * 2, right: padding * 2))
        
    }
    
    fileprivate func insertGradient(_ color: UIColor, _ contrast: UIColor) {
        let leftColor = color.cgColor
        let rightColor = contrast.cgColor
        gradient.colors = [leftColor, rightColor]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 2, y: 1.2)
        innerView.layer.insertSublayer(gradient, at: 0)
    }
    
    override func layoutSubviews() {
        gradient.frame = bounds
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
