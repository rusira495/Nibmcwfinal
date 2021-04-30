//
//  FoodViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/30/21.
//

import UIKit

class FoodViewController: UIViewController {
    

    @IBOutlet weak var tblFood: UITableView!
    
 //   var fooditem1 = fooditem(_id: "001", foodname: "Doughnut", fooddescription: "Chocolate Flovard daughnut", foodprice: 200, discount: 10, image: "doughnut")
    
  //  var fooditem2 = fooditem(_id: "002", foodname: "Sandwitch", fooddescription: "Club Sandwich", foodprice: 250, discount: 10, image: "sandwich")
    
   // var fooditem3 = fooditem(_id: "003", foodname: "Shawarma", fooddescription: "Chicken Shawarma", foodprice: 200, discount: 0, image: "shawarma")
    
   // var fooditem4 = fooditem(_id: "004", foodname: "Burger", fooddescription: "Cheese Burger", foodprice: 300, discount: 0, image: "hamburger")
    
  //  var fooditem5 = fooditem(_id: "005", foodname: "Taco", fooddescription: "Seafood Taco", foodprice: 700, discount: 25, image: "taco")
    
    
    var foodItems: [fooditem] = [
        
        fooditem(_id: "001", foodname: "Doughnut", fooddescription: "Chocolate Flovard daughnut", foodprice: 200, discount: 10, image: "doughnut"),
        
        fooditem(_id: "002", foodname: "Sandwitch", fooddescription: "Club Sandwich", foodprice: 250, discount: 10, image: "sandwich"),
        
        fooditem(_id: "003", foodname: "Shawarma", fooddescription: "Chicken Shawarma", foodprice: 200, discount: 0, image: "shawarma"),
        
        fooditem(_id: "004", foodname: "Burger", fooddescription: "Cheese Burger", foodprice: 300, discount: 0, image: "hamburger"),
        
        fooditem(_id: "005", foodname: "Taco", fooddescription: "Seafood Taco", foodprice: 700, discount: 25, image: "taco")
                          ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblFood.register(UINib(nibName: "FoodTableViewCell", bundle: nil), forCellReuseIdentifier: "FoodCellReuseIdentifer")
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
