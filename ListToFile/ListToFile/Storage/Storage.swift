//
//  Storage.swift
//  ListToFile
//
//  Created by Yewon Seo on 2020/02/28.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import Foundation
class Storage {
    
    private static var _list = read()
    private static var filename = "data.dat"
    
    static func read() -> [String] {
        let path = getDocumentDir().appendingPathComponent(filename)
        if let arr = NSArray(contentsOf: path) as? [String] {//cast the type as string
            return arr
        }
        return [String]() // else, returns empty array
        
    }
    
    static func addItem(str:String) {
        _list.append(str)
        save()
    }
    
    static func remove(index:Int) {
        _list.remove(at: index)
        save()
    }
    
    static func edit(index:Int, str:String) {
        _list[index] = str
        save()
    }
    
    private static func save() {
        let nsArr = _list as NSArray
        let path = getDocumentDir().appendingPathComponent(filename)
        
        nsArr.write(to: path, atomically: true)
    }

    
    private static func getDocumentDir() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return url[0]
    }
}
