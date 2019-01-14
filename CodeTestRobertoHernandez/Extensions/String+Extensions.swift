//
//  String+Extensions.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 1/14/19.
//  Copyright © 2019 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

extension String {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }
        
        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }
        
        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
