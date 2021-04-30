//
//  FoodViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/30/21.
//

import UIKit
import Firebase
import SwiftyJSON

class FoodViewController: UIViewController {
    

    @IBOutlet weak var tblFood: UITableView!
    
    var ref: DatabaseReference!
    
    var foodItems: [fooditem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFood.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifer")
        ref = Database.database().reference()
        getfoodItemsData()
    }
      
}
extension FoodViewController {
    func  getfoodItemsData()  {
        ref.child("foodItems").observe(.value, with: {
            (snapshot) in
            
            if let data = snapshot.value {
                if let foodItems = data as? [String: Any] {
                    for item in foodItems {
                        if let foodInfo = item.value as? [String: Any] {
                            let singlefoodInfo = fooditem(
                                _id: "",
                                foodname: foodInfo["name"] as! String,
                                fooddescription: foodInfo["description"] as! String,
                                foodprice: foodInfo["price"] as! Double,
                                discount: foodInfo["discount"] as! Int,
                                image: foodInfo["image"] as! String,
                                category: foodInfo["category"] as! String)
                            
                            self.foodItems.append(singlefoodInfo)
                      }
                    }
                    self.tblFood.reloadData()
                    
                }
                
            }
    
    })
    }
}

extension FoodViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblFood.dequeueReusableCell(withIdentifier: "FoodCellReuseIdentifer", for: indexPath) as! FoodTableViewCell
        cell.seteupView(fooditem: foodItems[indexPath.row])
        return cell
        
    }
}
