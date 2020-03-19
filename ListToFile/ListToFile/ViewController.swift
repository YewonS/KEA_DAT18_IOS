//
//  ViewController.swift
//  ListToFile
//
//  Created by Yewon Seo on 2020/02/28.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var fromFileArr = Storage.read()
        print(fromFileArr) // if this works, then the file was read correctly
        Storage.addItem(str: "hello")
        fromFileArr = Storage.read()
        print(fromFileArr)
    }


}

