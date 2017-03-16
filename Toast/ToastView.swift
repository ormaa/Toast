//
//  ToastView.swift
//
//  Created by Olivier Robin on 14/03/2017.
//  Copyright © 2017 www.ormaa.fr - All rights reserved.
//
import Foundation
import UIKit

class ToastView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var view: MyView!
    
    // used to move the view on the screen
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var left: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setAlpha(alpha: CGFloat) {
        DispatchQueue.main.async {
            if alpha <= 1.0 {
                self.view.alpha = alpha
            }
            else {
                self.view.alpha = 1.0
            }
        }
    }

}
