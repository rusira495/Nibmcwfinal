//
//  MenuViewController.swift
//  Nibmcwfinal
//
// Created by Rusira on 5/09/21.
//

import UIKit
import iOSDropDown
import Firebase
class MenuViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    private let database = Database.database().reference()
    var storage = Storage.storage()
    @IBOutlet weak var button:UIButton!
    @IBOutlet weak var dropDown : DropDown!
    
    @IBOutlet weak var name :UITextField!
    @IBOutlet weak var desc :UITextField!
    @IBOutlet weak var price :UITextField!
    @IBOutlet weak var discount :UITextField!
    @IBOutlet weak var sellType :UISwitch!
    @IBOutlet weak var image:UIImageView!
    var catSelectedItem = ""
    var imageId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        button.isEnabled=false
        loadDropDown()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
                image.isUserInteractionEnabled = true
                image.addGestureRecognizer(tapGestureRecognizer)
        // Do any additional setup after loading the view.
    }
    
    func loadDropDown(){
        let group = DispatchGroup()
        self.database.child("Category").getData { (error, snapshot) in
            if snapshot.exists(){
                let dataChange = snapshot.value as! [String:AnyObject]
                group.wait()
               
                dataChange.forEach({ (key,val) in
                  
                    
                    self.dropDown.optionArray.append(val as! String)
                    
                  
                })
                
                group.notify(queue: .main) {
                        // do something here when loop finished
                   
                    self.dropDown.didSelect{(selectedText , index ,id) in
                        self.catSelectedItem=selectedText
                    }
                }
            }
        }
    }
    
    
    
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = false
        imagePickerController.mediaTypes = ["public.image"]
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.modalPresentationStyle = .fullScreen
        present(imagePickerController,animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
     
        var selectedimage = info[.originalImage] as! UIImage //retrieve the image

        let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
        //we should resize the image or takes very lont time for image upload
        selectedimage = resizeImage(image: selectedimage, targetSize: CGSize(width: image.frame.width, height: image.frame.height))
        let id=UUID().uuidString
        storage.reference(withPath:  "/\(id).jpg")
            //saving the profile image by user image id as png file
            .putData(selectedimage.pngData()!, metadata: metaData) {metaData,error in
                if error == nil{
                    
                    self.image.image = selectedimage
                    self.imageId=id
                    
                }else{
                    print(error)
                  
                }
                self.button.isEnabled=true
                
            }
       
        
        
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    func displayAlert(){
        let alert = UIAlertController(title: "Error", message: "Some fields are empty!", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func btnAdd(_ sender: Any) {
        
        if(name.text!.isEmpty || desc.text!.isEmpty || price.text!.isEmpty || imageId.isEmpty || catSelectedItem.isEmpty ||  discount.text!.isEmpty){
            displayAlert()
        }else{
            
        
        
        
        let menu = MenuItem(name: name.text!, desc: desc.text!, price: Double(price.text!)!, img: imageId, category: catSelectedItem, discount: Int(discount.text!)!, sellType: sellType.isOn)
        
        
        
        
            let child = Int.random(in: 0...1000)
        self.database.child("MenuItems").child(String(child)).setValue(menu.getJSON())
            
            let alert = UIAlertController(title: "Success", message: "Row Added Success!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
