//
//  IconImageView.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/19/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

class IconImageView: UIImageView {
    let size: CGFloat
    
    init(size: CGFloat) {
        self.size = size
        super.init(frame: .zero)
        contentMode = .scaleAspectFit
        heightAnchor.constraint(equalToConstant: size).isActive = true
        widthAnchor.constraint(equalToConstant: size).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
