//
//  ViewController.swift
//  Toast
//
//  Created by Olivier Robin on 16/03/2017.
//  Copyright © 2017 fr.ormaa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    @IBAction func shortClick(_ sender: UIButton) {
        Toast.short(message: "This is a short message over the topmost view controller : " + String(describing: Date()))
     }

    @IBAction func longClick(_ sender: UIButton) {
        Toast.long(message: "This is a message over the topmost view controller : " + String(describing: Date()))
    }
}


