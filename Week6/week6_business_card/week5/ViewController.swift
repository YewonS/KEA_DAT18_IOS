//
//  ViewController.swift
//  week6_business_card
//
//  Created by Yewon Seo on 2020/02/07.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var txtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        
        print("hi")
        if let name = txtField.text {
            //if there's sth inside the box, do the following
            label.text = "Hello, \(name)"
        }

    }
    
}

