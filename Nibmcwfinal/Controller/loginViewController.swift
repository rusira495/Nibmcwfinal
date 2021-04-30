//
//  loginViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/29/21.
//

import UIKit
import Firebase
import Loaf

class loginViewController: UIViewController {
    
    
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    var ref: DatabaseReference!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
    }
    @IBAction func onloginpressed(_ sender: UIButton) {
        if validateInput() {
            authenticateuser(email: txtemail.text!, password: txtpassword.text!)
            
            
        } else {
            print("Input Error Found")
            
        }
        
        
    }
    
    func validateInput() -> Bool {
        

        guard let email = txtemail.text else {
            print("Email is Null")
            return false
        }
        
        guard let password = txtpassword.text else {
            print("Password is Null")
            return false
        }
        
        if email.count < 5 {
            print("Enter valid Email")
            return false
        }
        
        if password.count < 5 {
            print("Enter valid password")
            return false        }
        
        return true
    }
    
    func authenticateuser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [self]
            authResult, error in
            
            if let err = error {
                print(err.localizedDescription)
                Loaf("User Name is Invalid", state: .success, sender: self).show()
                return
            }
            
            if let email = authResult?.user.email {
                self.getUserData(email: email)
            }else {
                Loaf("User email not found", state: .error, sender: self).show()
            }
            
            
            
            // save user logged state
            _ = SessionManager()
            
            self.performSegue(withIdentifier: "SignInToHome", sender: nil)
                
            }
        }
    
    func getUserData(email: String) {
        
    }
        
    }
