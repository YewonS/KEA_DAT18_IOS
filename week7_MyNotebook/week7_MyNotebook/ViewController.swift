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
    var inputText: String = ""
    var currentRowToEdit = -1 // -1 mean no editing
    let fileName = "theString.txt"
    
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
        
        // make text field blank
        inputText = txtField.text ?? ""
        
        // if it's editing, don't put it on the new line, just make sure it goes back to the same line
        if currentRowToEdit > -1 {
            textArray[currentRowToEdit] = inputText
            currentRowToEdit = -1
        } else {
            textArray.append(inputText)
        }
        
        // reload data after saving and then save it to file as well
        table.reloadData()
        txtField.text = ""
        saveStringToFile(str: inputText, fileName: fileName)
        print(readStringFromFile(fileName: fileName))
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return textArray.count
    }
    
    // connects cells.. to an array
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell1")
           cell?.textLabel?.text = textArray[indexPath.row]
        
         return cell!
    }
    
    // get the current row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("you clicked \(indexPath.row)")
        currentRowToEdit = indexPath.row
        txtField.text = textArray[currentRowToEdit]
    
    }
    
    func saveStringToFile (str:String, fileName:String){

        let filePath = getDocumentDir().appendingPathComponent(fileName)
        
        do {
            try str.write(to: filePath, atomically: true, encoding: .utf8)
            print("String written to the file \(str)")
        } catch {
            print("Error occured while writing into the file \(str)")
        }
    }
    //atomic means you either do it or not do it at all. if the process is shut down during the process, it will go back.
    
    func getDocumentDir() -> URL {
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(documentDir)
        return documentDir[0]
    }
    
    func readStringFromFile(fileName:String) -> String {
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        
        do{
            let string = try String(contentsOf: filePath, encoding: .utf8)
            return string
        } catch {
            print("Error while reading file \(fileName)")
        }
        
        return "empty"
    }
    
    // swipe to delete
    func tableView(_ table: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            textArray.remove(at: indexPath.row)
            table.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

 
