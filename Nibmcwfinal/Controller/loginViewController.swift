//
//  loginViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/29/21.
//

import UIKit

class loginViewController: UIViewController {
    
    
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var txtpassword: UITextField!
    
    var number: Int?
    var fetchedNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    @IBAction func onloginpressed(_ sender: UIButton) {
    
        if let email = txtemail.text {
            if email.count < 5 {
                
            }
            
        }
    }
    
}
