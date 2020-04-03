//
//  ViewController.swift
//  login
//
//  Created by Yewon Seo on 2020/04/03.
//  Copyright © 2020 Yewon Seo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var auth = Auth.auth()
    var firebaseManager:FirebaseManager?
    var facebookManager:FacebookManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self)
        facebookManager = FacebookManager(parentVC: self)
        
        auth.addIDTokenDidChangeListener { (auth, user) in
            if user != nil {
                print("Status: user is logged in \(String(describing: user))")
            } else {
                print("Status: user is logged out")
            }
        }
    }


    @IBAction func signupButtonPressed(_ sender: Any) {
        if verify().isOK {
            firebaseManager?.signUp(email: verify().email, pwd: verify().pwd)
            }
        }
        
    
       @IBAction func loginPressed(_ sender: Any) {
           if verify().isOK {
           firebaseManager?.logIn(email: verify().email, pwd: verify().pwd)
           }
       }
       
       
       @IBAction func logoutPressed(_ sender: Any) {
           firebaseManager?.logOut()
       }
    
    
    @IBAction func facebookLoginPressed(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile], viewController: self) { (result) in
                print("logged in to facebook \(result)")
            switch result {
            case .cancelled:
                print("login was cancelled")
                break
            case .failed(let error):
                print("login failed \(error.localizedDescription)")
                break
            case let .success(granted: _, declined: _, token: token):
                print("facebook login succeed \(token.userID)")
                self.firebaseManager?.logInUsingFacebook(tokenString: token.tokenString)
            }
        }
    }
    
    @IBAction func loadFBdataPressed(_ sender: Any) {
        facebookManager?.makeGraphRequest()
        
    }
    
       
    func verify() -> (email:String, pwd:String, isOK:Bool) {
       if let email = email.text, let pwd = password.text {
           if email.count > 5 && pwd.count > 5 {
               return (email, pwd, true)
           }
       }
       return ("","",false)
    }
       
    func presentSecretVC() {
        performSegue(withIdentifier: "secretSegue", sender: self)
    }
    
}
