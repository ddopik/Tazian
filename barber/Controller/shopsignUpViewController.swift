//
//  shopsignUpViewController.swift
//  barber
//
//  Created by amr sobhy on 3/3/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuthUI

class shopsignUpViewController: UIViewController {
    var address_shop = ""
    @IBOutlet weak var shopNameText: UITextField!
    var shopname = ""
    @IBOutlet weak var ownerName: UITextField!
     var owner = ""
    @IBOutlet weak var licenseText: UITextField!
     var license = ""
    @IBOutlet weak var addressText: UITextField!
    var phone = ""
    var city = ""
    var latitude = 0.0
    var longtude = 0.0
   
    @IBOutlet weak var pickBtn: UIButton!
     @IBOutlet weak var nextBtn: UIButton!
    
     var ref : DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        shopNameText.TextborderRound()
        ownerName.TextborderRound()
        licenseText.TextborderRound()
        addressText.TextborderRound()
        nextBtn.ButtonborderRound()
        addressText.isEnabled = false
       
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         addressText.text = address_shop
         shopNameText.text = shopname
         ownerName.text = owner
         licenseText.text = license
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pickAction(_ sender: Any) {
        
    }
    
    @IBAction func nextAction(_ sender: Any) {
        if userType == 3 {
             let userId = self.ref.childByAutoId().key
            var newShopClass = Shop.init(isAdmin: false, membersince: [".sv": "timestamp"] as AnyObject, isOnline: true, imageURL1: "", imageURL2: "", imageURL3: "", imageURL4: "", shopID: userId, token: token, personInCharge: "", title: shopNameText.text!, phone: self.phone as! String, cr_number: licenseText.text!, address: addressText.text!, city: self.city, longtude: self.longtude, latitude: self.latitude, type: userType, price: 0.0, service: 0.0, waiting: 0.0, rate: 0.0)
            
             var newShop = newShopClass?.getData()
            print(newShop)
            print("newShopClass")
            self.ref.child("users").child("shops").child(userId).setValue(newShop)
            saveUserData(userData: newShop! )
            var mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "signUpGalleryView") as? signUpGalleryViewController
            
            self.navigationController?.pushViewController(mainScreen!, animated: true)
        }
        
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let toViewController = segue.destination as? MapViewController {
            toViewController.shopname = self.shopNameText.text!
            toViewController.name = self.ownerName.text!
            toViewController.licensce = self.licenseText.text!
        }
    }
    

}
