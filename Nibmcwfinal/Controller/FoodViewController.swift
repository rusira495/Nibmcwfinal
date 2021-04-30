//
//  FoodViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 4/30/21.
//

import UIKit

class FoodViewController: UIViewController {
    

    @IBOutlet weak var tblFood: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension FoodViewController : UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}
