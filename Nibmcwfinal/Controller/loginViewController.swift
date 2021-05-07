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
        
        if !InputFieldValidator.isValidEmail(txtemail.text ?? "") {
            Loaf("Invalid Email Address", state: .error, sender: self).show()
            return
        }
        
        if !InputFieldValidator.isValidPassword(pass: txtpassword.text ?? "", minLength: 6, maxLength: 50) {
            Loaf("Invalid Password", state: .error, sender: self).show()
            return
        }
        
        authenticateuser(email: txtemail.text!, password: txtpassword.text!)
        
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
                Loaf("User email Not found", state: .success, sender: self).show()
                return
            }
            
            
            
            
                
            }
        }
    
    func getUserData(email: String) {
        ref.child("users")
            .child(email
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_") ).observe(.value, with: {
            (snapshot) in
                
                    if snapshot.hasChildren(){
                        if let data = snapshot.value {
                            
                    if let userData = data as? [String: String] {
                    let User = user(
                        username: userData["username"] ?? "",
                        useremail: userData["useremail"]!,
                        userpassword: userData["userpassword"]!,
                        userphone: userData["userphone"]!)
                                
                               let sessionMGR = SessionManager()
                                sessionMGR.saveuserlogin(user: User)
                        self.performSegue(withIdentifier: "SignInToHome", sender: nil)                          }
                        }
                    }else{
                        Loaf("User Not found", state: .success, sender: self).show()                    }
                
        
    }
            )}
}
