//
//  UITextField+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 1/8/19.
//  Copyright © 2019 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

extension UITextField {
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = ValidatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}
