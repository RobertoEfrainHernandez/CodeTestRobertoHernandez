//
//  UIColor+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/24/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit
import ChameleonFramework

extension UIColor {
    static let mainColor = #colorLiteral(red: 0.7803921569, green: 0, blue: 0.2235294118, alpha: 1)
    static let mainContrastColor = ContrastColorOf(#colorLiteral(red: 0.7803921569, green: 0, blue: 0.2235294118, alpha: 1), returnFlat: true)
}
