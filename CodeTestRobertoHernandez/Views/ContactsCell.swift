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
    fileprivate let containerView = ContainerView()
    
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
            let color = UIColor(hexString: contact?.color ?? "3182D9")
            
            nameLabel.text = name
            phoneLabel.text = phone
            emailLabel.text = email
            
            containerView.backgroundColor = color
            nameLabel.textColor = ContrastColorOf(color ?? .white, returnFlat: true)
            phoneLabel.textColor = ContrastColorOf(color ?? .white, returnFlat: true)
            emailLabel.textColor = ContrastColorOf(color ?? .white, returnFlat: true)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        setLayout()
    }
    
    fileprivate func setLayout() {
        addSubview(containerView)
        containerView.fillSuperview(padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        
        let mainStack = UIStackView(arrangedSubviews: [nameLabel, phoneStack, emailStack])
        mainStack.axis = .vertical
        [mainStack, phoneStack, emailStack].forEach({ $0.spacing = spacing })
        
        containerView.addSubview(mainStack)
        mainStack.fillSuperview(padding: .init(top: padding * 2, left: padding * 2, bottom: padding * 2, right: padding * 2))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
