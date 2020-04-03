//
//  FacebookManager.swift
//  login
//
//  Created by Yewon Seo on 2020/04/03.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import Foundation
import FacebookCore

class FacebookManager {
    
    let parentVC: ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
    }
    
    func makeGraphRequest() {
        if let tokenStr = AccessToken.current?.tokenString {
            let graphRequest = GraphRequest(graphPath: "/me", parameters: ["fields":"id, name, email"], tokenString: tokenStr, version: Settings.defaultGraphAPIVersion, httpMethod: .get)
            let connection = GraphRequestConnection()
            connection.add(graphRequest) { (connection, result, error) in
                if error == nil, let res = result {
                    print("got data from Facebook")
                    let dict = res as! [String:Any] // cast to dictionary
                    let name = dict["name"] as! String
                    print("got data from Facebook. Name: \(name)")
                    
                } else {
                    print("error getting data from facebook \(error.debugDescription)")
                }
            }
            connection.start()
        }
    }
    
}
