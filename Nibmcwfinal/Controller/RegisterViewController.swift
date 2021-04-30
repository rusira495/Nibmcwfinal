//
//  RegisterViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/29/21.
//

import UIKit
import Firebase
import Loaf

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var txtpassword: UITextField!
    @IBOutlet weak var txtphoneno: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onregister1pressed(_ sender: UIButton) {
        if validateInput() {
            registeruser(email: txtemail.text!, password: txtpassword.text!)
            
        }else {
            print("Input Error found")
        }
        
    }
    
    @IBAction func onRegisterPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func registeruser(email: String,password: String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                Loaf("User Sign up Failed", state: .error, sender: self).show()
                return
            }
            
            
            
            if let results = authResult {
                print("user added with email: \(results.user.email ?? "Not Found")")
                Loaf("User Register Success", state: .success, sender: self).show()
            }
            
        }
    }
    
    
    func saveUserData(user: user){
        self.ref.child("users").child(user.useremail).setValue(user) {
            (Error,ref) in
            
            if let err = Error {
                print(err.localizedDescription)
                Loaf ("User Sign in failed", state:.error,sender:self).show()
                return
                }
                
            Loaf ("User Data save in database", state:.success,sender:self).show()
        }
    }
    
    func validateInput() ->Bool {
        
        guard let email = txtemail.text else {
            print("Email is Null")
            return false
        }
        
        guard let phoneno = txtphoneno.text else {
            print("Phoneno is Null")
            return false
        }
        
        guard let password = txtpassword.text else {
            print("Password is Null")
            return false
        }
        
        if email.count < 5 {
            print("Enter Email")
            return false
        }
        
        if phoneno.count < 5 {
            print("Enter Valid PhoneNO")
            return false
        }
        
        if password.count < 5 {
            print("Enter Correct Password")
            return false
        }
        
        return true
    }
        
    }
    

