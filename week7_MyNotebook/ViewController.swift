//
//  ViewController.swift
//  week7_MyNotebook
//
//  Created by Yewon Seo on 2020/02/14.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//
import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var txtField: UITextView!
    @IBOutlet weak var table: UITableView!
    var textArray = [String]()
    var tableArray = [String]()
    
    var inputText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textArray.append("hello")
        table.dataSource = self
        table.delegate = self
     
    }

    override func viewWillAppear(_ animated: Bool) {
        table.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableView.ScrollPosition(rawValue: 0)!)
    }
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        
        inputText = txtField.text ?? ""
        textArray.append(inputText)
        txtField.text = ""
        table.reloadData()
        
        print(textArray)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell1")
           cell?.textLabel?.text = textArray[indexPath.row]
        
         return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.tableArray[indexPath.row])
    }
    
}

 
