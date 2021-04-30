//
//  FoodTableViewCell.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/30/21.
//

import UIKit

class FoodTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var viewContainerDiscount: UIView!
    
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblFoodPrice: UILabel!
    @IBOutlet weak var lblFoodDescription: UILabel!
    @IBOutlet weak var lblFoodName: UILabel!
    @IBOutlet weak var imgFood: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func seteupView(fooditem: fooditem) {
        lblFoodName.text = fooditem.foodname
        lblFoodDescription.text = fooditem.fooddescription
        lblFoodPrice.text = "LKR \(fooditem.foodprice)"
        imgFood.image = UIImage(named: fooditem.image)
        
        if fooditem.discount > 0 {
            
            viewContainerDiscount.isHidden = false
            lblDiscount.text = "\(fooditem.discount)%"
        }else {
            viewContainerDiscount.isHidden = true
            lblDiscount.text = ""
        }
        
    }
    
}
