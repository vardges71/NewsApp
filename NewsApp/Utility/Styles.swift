//
//  Styles.swift
//  NewsApp
//
//  Created by Vardges Gasparyan on 2021-10-01.
//

import Foundation
import UIKit

class Styles {
    
    static func styleTextField(_ textfield: UITextField) {
        
        // Create the bottom line
//        let bottomLine = CALayer()
        
//        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height, width: textfield.frame.width, height: 1)
        
//        bottomLine.backgroundColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 1).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        // Set border styles
        textfield.layer.borderWidth = 0
        textfield.layer.borderColor = .none
        textfield.layer.cornerRadius = 4.0
        
        // Add the line to the text field
//        textfield.layer.addSublayer(bottomLine)
        
        // Set background Color
        textfield.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        textfield.textColor = UIColor.init(red: 210/255, green: 112/255, blue: 89/255, alpha: 1)

    }
    
    static func asStrokeButton (_ button: UIButton) {
        
        button.layer.borderWidth = 0
        button.backgroundColor = UIColor.init(red: 135/255, green: 180/255, blue: 255/255, alpha: 0)
//        button.layer.borderColor = UIColor.init(red: 60/255, green: 90/255, blue: 150/255, alpha: 1).cgColor
//        button.layer.cornerRadius = 5.0
        button.tintColor = UIColor.init(red: 210/255, green: 112/255, blue: 89/255, alpha: 1)
    }
    
    static func shadowButton(_ button: UIButton) {
        
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 8.0
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 19, weight: .light)
    }
    
    static func styleFilledButton(_ button: UIButton) {
        
        // Filled rounded corner style
        button.layer.borderWidth = 2
        button.backgroundColor = UIColor.init(red: 98/255, green: 85/255, blue: 49/255, alpha: 0.8)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 5.0
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.tintColor = UIColor.white
    }
    
    static func verticalTitleImage (button: UIButton) {
        
        let spacing: CGFloat = 3.0
        
        let imageSize = button.imageView!.frame.size
        
        button.layer.borderWidth = 0
        button.backgroundColor = UIColor.init(red: 135/255, green: 180/255, blue: 255/255, alpha: 0)
        button.layer.borderColor = UIColor.init(red: 60/255, green: 90/255, blue: 150/255, alpha: 1).cgColor
        button.layer.cornerRadius = 5.0
//        button.tintColor = UIColor.init(red: 90/255, green: 0/255, blue: 15/255, alpha: 1)
        
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0)
        
        let titleSize = button.titleLabel!.frame.size
        
        button.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
    }
}

class MyTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

