//
//  ViewController.swift
//  customCellDemo
//
//  Created by Yewon Seo on 2020/03/13.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var stories = [Story]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stories.append(Story(txt: "hi there", img: ""))
        stories.append(Story(txt: "how are you doing", img: ""))
        stories.append(Story(txt: "cute cat there", img: "cat1"))
        tableView.dataSource = self // assign this class to handle data for the table view
        tableView.delegate = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    } // how many items there are
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if stories[indexPath.row].hasImage() {
            //handle case where there is image
            if let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2") as? TableViewCellWithImage {
                cell2.label2.text = stories[indexPath.row].text
                cell2.myimage.image = UIImage(named: stories[indexPath.row].image)
                return cell2
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as? TableViewCellTextOnly {
                cell.mylabel.text = stories[indexPath.row].text
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return stories[indexPath.row].hasImage() ? 200 : 80 // adjust the height of the row (ternary operator)
    }
    
    
}

