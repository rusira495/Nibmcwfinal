//
//  AccountViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 5/7/21.
//

import UIKit

class AccountViewController: UIViewController {
    
    let sessionMGR = SessionManager()
    
    @IBOutlet weak var txtUsername: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = sessionMGR.getUserData()
        txtUsername.text = user.username
        txtEmail.text = user.useremail
        txtPhone.text = user.userphone

    }
    
    @IBAction func onSignOutPressed(_ sender: UIButton) {
        
    }
    
}
