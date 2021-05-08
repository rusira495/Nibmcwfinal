//
//  CartViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 5/8/21.
//

import UIKit
import Firebase
import Loaf

class CartViewController: UIViewController {
    
    
    @IBOutlet weak var tblCartitems: UITableView!
    
    var cartItems: [fooditem] = []
    
    let sessionMGR = SessionManager()
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.cartItems = CartHandler.getCartItems()
        tblCartitems.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifer")
        
    }
    
    @IBAction func onComfirmPressed(_ sender: Any) {
        saveOrder()
        
    }
    
    
    @IBAction func onBackPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension CartViewController {
    func saveOrder() {
        
        var orderData: [String: Any] = [:]
        var foodItemInfo: [String: Any] = [:]
        
        for index in 0..<cartItems.count {
            foodItemInfo.removeAll()
            foodItemInfo["foodname"] = cartItems[index].foodname
            foodItemInfo["fooddescription"] = cartItems[index].fooddescription
            foodItemInfo["foodprice"] = cartItems[index].foodprice
            orderData["\(index)"] = foodItemInfo
        }
        
        self.ref.child("Orders")
            .child(sessionMGR.getUserData().useremail
            .replacingOccurrences(of: "@", with: "_")
            .replacingOccurrences(of: ".", with: "_") )
            .childByAutoId()
            .setValue(orderData) {
            (error,ref) in
            
            if let err = error {
                print(err.localizedDescription)
                Loaf("Order Data Not Saved On Database", state: .success, sender: self).show()
                return
            }
            
                Loaf("Order Data Saved On Database", state: .success, sender: self).show {
                    type in
                    
                CartHandler.clearCart()
                self.dismiss(animated: true, completion: nil)
                }
        }

    }
}


extension CartViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblCartitems.dequeueReusableCell(withIdentifier: "FoodCellReuseIdentifer", for: indexPath) as! FoodTableViewCell
        cell.seteupView(fooditem: cartItems[indexPath.row])
        return cell
        
    }
    
    
}
