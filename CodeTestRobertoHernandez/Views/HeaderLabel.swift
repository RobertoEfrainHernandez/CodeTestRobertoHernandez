//
//  HeaderLabel.swift
//  CodeTestRobertoHernandez
//
//  Created by Roberto Hernandez on 12/21/18.
//  Copyright © 2018 Roberto Efrain Hernandez. All rights reserved.
//

import UIKit

class HeaderLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 0))
    }
}

class HeaderView: UIView {
    
    let stackPadding: CGFloat = 8
    let headerLabel : UILabel = {
        let label = HeaderLabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "Add Box Outline")!
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.contentMode = .scaleAspectFit
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.9, alpha: 1)
        setUpStack()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setUpStack() {
        let stack = UIStackView(arrangedSubviews: [headerLabel, addButton])
        stack.axis = .horizontal
        stack.spacing = stackPadding
        addSubview(stack)
        stack.fillSuperview(padding: .init(top: stackPadding, left: stackPadding, bottom: stackPadding, right: stackPadding * 3))
    }
}
