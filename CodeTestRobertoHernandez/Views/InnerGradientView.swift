//
//  InnerGradientView.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 1/14/19.
//  Copyright © 2019 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

class InnerGradientView: UIView {
    let color: UIColor
    let contrast: UIColor

    override func draw(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer()
        let leftColor = color.cgColor
        let rightColor = contrast.cgColor
        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 2, y: 1.2)
        
        layer.insertSublayer(gradientLayer, at: 0)
        layer.cornerRadius = 12
        clipsToBounds = true
        gradientLayer.frame = rect
    }
    
    init(color: UIColor, contrast: UIColor) {
        self.color = color
        self.contrast = contrast
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
