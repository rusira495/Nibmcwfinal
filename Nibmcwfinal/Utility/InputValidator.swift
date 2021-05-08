//
//  InputValidator.swift
//  Nibmcwfinal
//
//  Created by Rusira on 5/7/21.
//

import Foundation

class InputFieldValidator {
    
    //MARK: - Regular Expressions

    static let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let nameRegEx = "[A-Za-z ]{2,100}"
    static let mobileRegex = "^(07)(0|1|2|4|5|6|7|8)[\\d]{7}$"
    
    
    //Validate the Email address with Regex
    static func isValidEmail(_ email: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    //Validates the passwords and checks it meets the requirements [MIN_LENGTH, MAX_LENGTH]
    static func isValidPassword(pass: String, minLength: Int, maxLength: Int) -> Bool {
        return pass.count >= minLength && pass.count <= maxLength
    }
    
    //Validates the mobile no
    static func isValidMobileNo(_ mobileNo: String) -> Bool{
        let mobPred = NSPredicate(format:"SELF MATCHES %@", mobileRegex)
        return mobPred.evaluate(with: mobileNo)
    }
    
    
    //Checks the length matches to the provided requirement
    static func checkLength(_ text: String, _ count: Int) -> Bool{
        return text.count >= count
    }
    
    //Check if the provided data is EMPTY or NULL
    static func isNotEmptyOrNil(_ text: String?) -> Bool {
        if text == nil || text == "" {
            return false
        } else{
            return true
        }
    }
}
