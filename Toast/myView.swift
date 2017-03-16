//
//  myView.swift
//
//  Created by ORMAA on 3/21/16.
//  Copyright © 2016 ORMAA. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class MyView: UIControl { //UIView {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        layer.cornerRadius = 0.5 * bounds.size.width
//        clipsToBounds = true
//    }
    
}
