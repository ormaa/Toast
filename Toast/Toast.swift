//
//  Toast.swift
//
//  Created by Olivier Robin on 14/03/2017.
//  Copyright © 2017 www.ormaa.fr - All rights reserved.
//

import Foundation
import UIKit

class ToastObject {
    var toastView: ToastView? = nil
    var toastAlpha: CGFloat = 1.5
    var toastDelta: CGFloat = 0.1
}

class Toast: NSObject {
    
    static var toastObjects: [ToastObject?] = []

    static var toastTimer: Timer? = nil
    
    static var topController: UIViewController? = nil
    
    // display a message, during long time
    static func long(message: String) {
        
        DispatchQueue.main.async {
            
            let toastView = UINib(nibName: "Toast", bundle: nil).instantiate(withOwner: self, options: [ : ])[0] as? ToastView

            topController = getTopController()
            topController?.view.addSubview(toastView!)
            setToastPosition(toastView: toastView!, index: toastObjects.count)

            let t = ToastObject()
            t.toastView = toastView
            t.toastAlpha = 1.5
            t.toastDelta = 0.01
            t.toastView?.title.text = message
            if toastTimer == nil {
                toastTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.025), target: self,
                                                selector: #selector(self.updateAlpha), userInfo: nil, repeats: true)
            }
            
            toastObjects.append(t)
        }
    }
    
        // display a message, during long short
    static func short(message: String) {
        
        DispatchQueue.main.async {
            
            let toastView = UINib(nibName: "Toast", bundle: nil).instantiate(withOwner: self, options: [ : ])[0] as? ToastView
            
            topController = getTopController()
            topController?.view.addSubview(toastView!)
            setToastPosition(toastView: toastView!, index: toastObjects.count)
            
            let t = ToastObject()
            t.toastView = toastView
            t.toastAlpha = 1.4
            t.toastDelta = 0.02
            t.toastView?.title.text = message
            if toastTimer == nil {
                toastTimer = Timer.scheduledTimer(timeInterval: TimeInterval(0.025), target: self,
                                                  selector: #selector(self.updateAlpha), userInfo: nil, repeats: true)
            }
            
            toastObjects.append(t)
        }
    }
    
    // get the top controller, in the chain
    static func getTopController() -> UIViewController {
        var topController = UIApplication.shared.keyWindow?.rootViewController
        while ((topController?.presentedViewController) != nil) {
            topController = topController?.presentedViewController
        }
        return topController!
    }
    
    // move the toast message, depending on how many are still displayed
    static func setToastPosition(toastView: ToastView, index: Int) {
        
        let x = CGFloat((topController?.view.frame.width)! / 2 - 150) // 150 is the half width of the toast message
        
        toastView.top.constant = CGFloat(200 + index * 50)
        toastView.left.constant = x
        toastView.frame.size = CGSize(width: 0, height: 0)
    }
    
    
    // Called a 1/50e sec.
    static func updateAlpha() {
        
        for index in 0...toastObjects.count - 1 {
            let o = toastObjects[index]
            if o != nil {
                let t = o?.toastView
                let alpha = o?.toastAlpha
                let delta = o?.toastDelta
                
                t?.setAlpha(alpha: alpha!)
                o?.toastAlpha = CGFloat(alpha! - delta!)
                
                if o!.toastAlpha <= CGFloat(0.1) {
                    // toast message can be removed
                    t?.removeFromSuperview()
                    toastObjects[index] = nil
                }
            }
        }
        
        purgeToast()
    }

    // will remove completed toast message
    static func purgeToast() {

        if toastObjects.count > 0 {
            
            var toastRemoved = false
            for index in 0...toastObjects.count - 1 {
                if toastObjects[index] == nil {
                    toastObjects.remove(at: index)
                    toastRemoved = true
                    break
                }
            }
            if toastRemoved {
                // we need to redo the process, like this : 
                // if we delete several object in the loop above, it will crash
                purgeToast()
                return
            }
            
            // move the toast message, like a stack
//            if toastObjects.count > 0 {
//                for index in 0...toastObjects.count - 1 {
//                    if toastObjects[index] != nil {
//                        setToastPosition(toastView: (toastObjects[index]?.toastView)!, index: index)
//                    }
//                }
//            }
        }
        else {
            toastTimer?.invalidate()
            toastTimer = nil
        }
    }
    

    
}
