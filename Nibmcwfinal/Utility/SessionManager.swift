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
    
    
    func saveuserlogin(user: user) {
        UserDefaults.standard.setValue(true, forKey: "User_LoggedIN")
    }
    
    
    func clearuserLoggedState() {
        UserDefaults.standard.setValue(false, forKey: "User_LoggedIN")
    }
    
}

