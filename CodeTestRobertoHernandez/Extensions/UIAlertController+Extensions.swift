//
//  UIAlertController+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

extension UIAlertController {
    @objc func handleMultipleTextChanged() {
        if let text1 = textFields?[0].text, let text2 = textFields?[1].text, let text3 = textFields?[2].text, let text4 = textFields?[3].text, let action = actions.last {
            action.isEnabled = !text1.isEmpty && !text2.isEmpty && !text3.isEmpty && !text4.isEmpty
        }
    }
    
    @objc func handleDoubleTextChanged() {
        if let text1 = textFields?[0].text, let text2 = textFields?[1].text, let action = actions.last {
            action.isEnabled = !text1.isEmpty && !text2.isEmpty
        }
    }
}
