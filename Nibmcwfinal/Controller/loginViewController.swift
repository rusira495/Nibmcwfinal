//
//  loginViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/29/21.
//

import UIKit
import Firebase

class loginViewController: UIViewController {
    
    
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        Auth.auth().signIn(withEmail: email, password: password) {
            authResult, error in
            
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            if let result = authResult {
                print("user Email: \(result.user.email ?? "No Found")")
            }
                
            }
        }
        
    }
