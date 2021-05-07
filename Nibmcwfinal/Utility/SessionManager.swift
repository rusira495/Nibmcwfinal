//
//  SessionManager.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/30/21.
//

import Foundation

class SessionManager {
    
    func getLoggedState() -> Bool {
       return UserDefaults.standard.bool(forKey: "User_ Logged")
    }
    
    
    func saveuserlogin(user:user) {
        UserDefaults.standard.setValue(true, forKey: "User_LoggedIN")
        UserDefaults.standard.setValue(user.useremail, forKey: "User_Email")
        UserDefaults.standard.setValue(user.userphone, forKey: "User_Phone")
        UserDefaults.standard.setValue(user.userpassword, forKey: "User_password")
        
    }
    func getUserData() -> user {
        let User = user(
            username: UserDefaults.standard.string(forKey: "User_Name") ?? "",
            useremail: UserDefaults.standard.string(forKey: "User_Email") ?? "",
            userpassword: "",
            userphone: UserDefaults.standard.string(forKey: "User_Phone") ?? "")
        
        return User
     }
    
    
    }
    
    func clearuserLoggedState() {
        UserDefaults.standard.setValue(false, forKey: "User_Logged")
    }
    


