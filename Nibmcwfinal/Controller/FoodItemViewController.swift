//
//  FoodItemViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 5/7/21.
//

import UIKit
import Kingfisher

class FoodItemViewController: UIViewController {
    
    @IBOutlet weak var imgFood: UIImageView!
    @IBOutlet weak var iblFoodName: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    
    var foodItem: fooditem?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = self.foodItem{
            imgFood.kf.setImage(with: URL(string: item.image))
            iblFoodName.text = item.foodname
            lblFoodDescription.text = item.fooddescription
            lblFoodPrice.text = "LKR: \(item.foodprice)"
        }
    }
    
    
    @IBAction func btnbackpressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnAddToCart(_ sender: Any) {
        
        if let item = self.foodItem{
            CartHandler.FoodItems.append(item)
            
        }
        
        print(CartHandler.FoodItems)
    }
}
