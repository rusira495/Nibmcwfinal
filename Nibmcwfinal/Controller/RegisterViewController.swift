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
        
        
        if !InputFieldValidator.isValidPassword(pass: txtpassword.text ?? "", minLength: 6, maxLength: 50) {
            Loaf("Invalid Password", state: .error, sender: self).show()
            return
        }
        
        if !InputFieldValidator.isValidMobileNo(txtphoneno.text ?? "") {
            Loaf("Invalid Mobile NO", state: .error, sender: self).show()
            return
        }
        
        if !InputFieldValidator.isValidEmail(txtemail.text ?? "") {
            Loaf("Invalid Email", state: .error, sender: self).show()
            return
        }
        let User = user(username: txtemail.text ?? "", useremail: txtemail.text ?? "", userpassword: txtpassword.text ?? "", userphone: txtphoneno.text ?? "")
        
        registeruser(user: User)
    }
    
    @IBAction func onRegisterPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func registeruser(user: user){
        Auth.auth().createUser(withEmail: user.useremail, password: user.userpassword) { authResult, error in
            if let err = error {
                print(err.localizedDescription)
                Loaf("User Sign up Failed", state: .error, sender: self).show()
                return
            }
            
            
            self.saveUserData(user: user)
            
            if let results = authResult {
                print("user added with email: \(results.user.email ?? "Not Found")")
                Loaf("User Register Success", state: .success, sender: self).show()
            }
            
        }
    }
    
    func saveUserData(user: user) {
        
        let UserData = [
            "username" : user.username,
            "useremail" : user.useremail,
            "userphone" : user.userphone,
            "userpassword" : user.userpassword
        ]
        
        self.ref.child("users")
            .child(user.useremail
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_") )
            .setValue(UserData) {
            (error,ref) in
            
            if let err = error {
                print(err.localizedDescription)
                Loaf("User Data Not Saved On Database", state: .success, sender: self).show()
                return
            }
            
                Loaf("User Data Saved On Database", state: .success, sender: self).show {
                    type in
                }
                self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
    }
    

