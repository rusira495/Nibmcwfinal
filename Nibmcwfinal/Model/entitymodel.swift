//
//  entitymodel.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/29/21.
//

import Foundation
import UIKit

struct user {
    var username: String
    var useremail: String
    var userpassword: String
    var userphone: String
    
}

struct fooditem {
    var _id: String
    var foodname: String
    var fooddescription: String
    var foodprice: Double
    var discount: Int
    var image: String
    var category: String
}

struct Category{
    var name:String!
    var id:String!
    func getJSON() -> NSMutableDictionary {
           let dict = NSMutableDictionary()
           dict.setValue(name, forKey: "name")
            dict.setValue(id, forKey: "id")
           return dict
       }
}



struct MenuItem{
    var name:String
    var desc:String
    var price:Double
    var img:String
    var category:String
    var discount:Int
    var sellType:Bool
    var image:UIImage!
    func getJSON() -> NSMutableDictionary {
           let dict = NSMutableDictionary()
           dict.setValue(name, forKey: "name")
            dict.setValue(desc, forKey: "desc")
            dict.setValue(price, forKey: "price")
            dict.setValue(img, forKey: "img")
            dict.setValue(category, forKey: "category")
            dict.setValue(discount, forKey: "discount")
            dict.setValue(sellType, forKey: "sellType")
           return dict
       }
}


//class user1 {
    
       // self.username = username
       // self.useremail = useremail
      //  self.userpassword = userpassword
    //    self.userphone = userphone
  //  }
