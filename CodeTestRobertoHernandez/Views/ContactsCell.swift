//
//  ContactsCell.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

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
        label.font = .systemFont(ofSize: 22, weight: .heavy)
        label.textColor = #colorLiteral(red: 0.0009986713994, green: 2.370890797e-05, blue: 0.2919406891, alpha: 1)
        label.text = "Roberto Hernandez"
        return label
    }()
    
    fileprivate let phoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "516-216-0467"
        return label
    }()
    
    fileprivate let emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.text = "reh9019@gmail.com"
        return label
    }()
    
    lazy var phoneStack = UIStackView(arrangedSubviews: [phoneImageView, phoneLabel])
    lazy var emailStack = UIStackView(arrangedSubviews: [emailImageView, emailLabel])

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        setLayout()
    }
    
    fileprivate func setLayout() {
        containerView.backgroundColor = .red
        addSubview(containerView)
        containerView.fillSuperview(padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        
        let mainStack = UIStackView(arrangedSubviews: [nameLabel, phoneStack, emailStack])
        mainStack.axis = .vertical
        [mainStack, phoneStack, emailStack].forEach({ $0.spacing = spacing })
        
        containerView.addSubview(mainStack)
        mainStack.fillSuperview(padding: .init(top: padding, left: padding, bottom: padding, right: padding))
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
