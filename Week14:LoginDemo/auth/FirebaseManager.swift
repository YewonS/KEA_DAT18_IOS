//
//  FirebaseManager.swift
//  login
//
//  Created by Yewon Seo on 2020/04/03.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import Foundation
import FirebaseAuth

class FirebaseManager {
    
    var auth = Auth.auth()
    var parentVC:ViewController
    
    init(parentVC:ViewController) {
        self.parentVC = parentVC
    }
    
    func signUp(email:String, pwd:String) {
        auth.createUser(withEmail: email, password: pwd) { (result, error) in
            if error == nil { // success
                print("successfully signed up to Firebase \(result.debugDescription)")
            }else {
                print("Failed to sign up \(error.debugDescription)")
            }
        }
    }
    
    func logIn(email:String, pwd:String) {
          auth.signIn(withEmail: email, password: pwd) { (result, error) in
              if error == nil { // success
                  print("successfully logged in to Firebase \(result.debugDescription)")
                self.parentVC.presentSecretVC()
              }else {
                  print("Failed to log in \(error.debugDescription)")
              }
          }
      }
    
    func logOut() {
        do {
            try auth.signOut()
            print("logged out")
        } catch let error {
            print("error signing out \(error.localizedDescription)")
        }
    }
    
    func logInUsingFacebook(tokenString:String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        auth.signIn(with: credential) { (result, error) in
            if error == nil{
                print("logged into firebase using facebook \(String(describing: result?.description))")
            } else {
                print("failed login to firebase using facebook \(error.debugDescription)")
            }
        }
    }
    
    
}
