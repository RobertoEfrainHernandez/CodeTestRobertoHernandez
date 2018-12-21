//
//  ContactInfoCell.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/21/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

class ContactInfoCell: UITableViewCell {

    let container = ContainerView()
    fileprivate let cellPadding: CGFloat = 16
    let infoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setContainerView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setContainerView() {
        addSubview(container)
        container.fillSuperview(padding: .init(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding))
        container.addSubview(infoLabel)
        infoLabel.fillSuperview(padding: .init(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding))
    }
    
}
