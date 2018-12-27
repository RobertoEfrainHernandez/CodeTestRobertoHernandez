//
//  NoContactsLabel.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/27/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

class NoContactsLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        text = "There are no Contacts.\nHow about we add some?"
        textAlignment = .center
        textColor = .mainColor
        numberOfLines = 0
        font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        layoutMargins = .init(top: 32, left: 32, bottom: 32, right: 32)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
