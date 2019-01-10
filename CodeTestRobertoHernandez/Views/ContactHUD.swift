//
//  ContactHUD.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 1/8/19.
//  Copyright © 2019 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import SVProgressHUD
import ChameleonFramework

class ContactHUD: SVProgressHUD {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultStyle = .custom
        defaultMaskType = .gradient
        minimumDismissTimeInterval = 3
        maximumDismissTimeInterval = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func setColor(color: UIColor) {
        let contrast = ContrastColorOf(color, returnFlat: true)
        setBackgroundColor(color)
        setForegroundColor(contrast)
    }
}
