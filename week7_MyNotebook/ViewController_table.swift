//
//  ViewController_table.swift
//  week7_MyNotebook
//
//  Created by Yewon Seo on 2020/02/14.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit

class ViewController_table: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var textArray = [String]() // we initialize an empty string array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
    
        return textArray.count
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = textArray[indexPath.row]
        return cell!
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
