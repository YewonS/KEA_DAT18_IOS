//
//  ViewController2.swift
//  week6_business_card
//
//  Created by Yewon Seo on 2020/02/07.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var control: UISegmentedControl!
    
    @IBOutlet weak var mainBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func controlSwitch(_ sender: Any) {
        
        
        switch control.selectedSegmentIndex {
        case 0:
            contactLabel.text = "22605057"
        case 1:
            contactLabel.text = "theUndefinedAvengersTheBest@kea.dk"
        default:
            contactLabel.text = "Contact me!"
            break
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
