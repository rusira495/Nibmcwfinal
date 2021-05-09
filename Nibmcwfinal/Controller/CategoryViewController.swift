//
//  CategoryViewController.swift
//  Nibmcwfinal
//
//  Created by Rusira on 5/09/21.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController {

    private let  database = Database.database().reference()
    @IBOutlet weak var tbl_category: UITableView!
    
    @IBOutlet weak var txt_name: UITextField!
    var catItems: [Category] = [
      
   ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib=UINib(nibName: "CategoryTableViewCell", bundle: nil)
        tbl_category.register(nib, forCellReuseIdentifier: "CategoryTableViewCell")
        self.tbl_category.delegate=self
        self.tbl_category.dataSource=self
        loadData()
        // Do any additional setup after loading the view.
    }
    
    
    func displayAlert(){
        let alert = UIAlertController(title: "Error", message: "Name Cannot Be Empty", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnAdd(_ sender: Any) {
        
        let cat=Category(name: txt_name.text)
    if let title = txt_name.text {
        if title.isEmpty {
            displayAlert()
        }else{
            
            catItems.append(cat)
            let child=UUID().uuidString
            self.database.child("Category").child(child).setValue(txt_name.text)
            self.tbl_category.reloadData()
            
        }
               
    }
 
    }
    
    
    func loadData(){
        let group = DispatchGroup()
        self.database.child("Category").getData { (error, snapshot) in
             if snapshot.exists() {
                
                let dataChange = snapshot.value as! [String:AnyObject]
              
                
              
                group.wait()
               
                dataChange.forEach({ (key,val) in
                  
                    let cart = Category(name: val as! String,id: key as! String)
                    
                
                    self.catItems.append(cart)
                    
                })
                
               
                
                group.notify(queue: .main) {
                        // do something here when loop finished
                    
                  
                    self.catItems.sorted() { $0.name > $1.name }
                    self.tbl_category.reloadData()
                }
               // print("Got data",snapshot.value!)
             }
        }
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CategoryViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return catItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=tableView.dequeueReusableCell(withIdentifier: "CategoryTableViewCell", for: indexPath) as! CategoryTableViewCell
     
        cell.setupView(cat: catItems[indexPath.row])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      
        if editingStyle == .delete {
           
            let id=catItems[indexPath.row].id!
            self.database.child("Category").child(id).removeValue()
            catItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
           }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
}
