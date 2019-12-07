//
//  signUpBarberViewController.swift
//  barber
//
//  Created by amr sobhy on 3/27/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI
import Toast
import Alamofire
import DropDown
class signUpBarberViewController: UIViewController {

    @IBOutlet weak var fullnameText: UITextField!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var nationalityText: UITextField!
    
    @IBOutlet weak var nationalityBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    var shop_data : [String:AnyObject]!
    var phone = ""
    var ref: DatabaseReference!
    var userId = ""
    var countries = [String]()
    var countriesDropDown = DropDown()
    var nationality = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        countries_api()
        self.nextBtn.ButtonborderRound()
        self.nationalityBtn.ButtonborderRoundradius(radius: 5)
        // Do any additional setup after loading the view.
    }

    @IBAction func nationalityAction(_ sender: Any) {
        self.countriesDropDown.show()
    }
    @IBAction func nextAction(_ sender: Any) {
        var fullname =  ""
        var username =  ""
        if fullnameText.text == "" {
            self.view.makeToast("You Have to enter your name")
             fullname = fullnameText.text ?? ""
            return
        }
        else if usernameText.text == "" {
            
            
             self.view.makeToast("You Have to enter your username")
            return
        } else{
            shop_data = UserDefaults.standard.value(forKey: "shop_data") as? [String:AnyObject] ?? [:]
            phone = UserDefaults.standard.value(forKey: "phone") as? String ?? ""
            print("shop_data\(shop_data)")
            print("phone\(phone)")
             username = usernameText.text ?? ""
            fullname = fullnameText.text ?? ""
            var newBarberClass = Barber.init(userID: userId, shopname: (shop_data["title"] as? String ?? "" )!, shopID: (shop_data["shopID"] as? String ?? "")!, fullname:fullname,phone:phone , username: username, token: token, nationality: "", imageURL: "", city_price: "", city_rate: "", price: 0.0, service: 0.0, waiting: 0.0, rate: 0.0, priceCount: 0, serviceCount: 0, waitingCount: 0, rateCount: 0, isOnline: true, address: "", city: "", longtiude: "" as! AnyObject, latitude: "" as! AnyObject, shopToken: (shop_data["token"] as? String ?? "")!, type: userType, isAdmin: false, membersince: [".sv": "timestamp"] as AnyObject)
            
            var newBarber = newBarberClass?.getData()
            print(newBarber)
            print("newShopClass")
            userData = newBarber ?? ["":"" as AnyObject]
            self.ref.child("users").child("barbers").child(userId).setValue(newBarber)
            print(newBarber!["shopID"] as! String)
            var value_update = ["\(userId)":true as? AnyObject]
            let childUpdates = [
                                "users/shops/\(newBarber!["shopID"] as! String)/barbersID/": value_update]
            self.ref.updateChildValues(childUpdates)
           
            saveUserData(userData: userData )
            var signUpGalleryView = self.storyboard?.instantiateViewController(withIdentifier: "barberSignUpGalleryView") as? barberSignUpGalleryViewController
            self.navigationController?.pushViewController(signUpGalleryView!, animated: true)
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func countries_api(){
        Alamofire.request("http://country.io/names.json").responseJSON{
            (response) in
            
            if let results = response.result.value as? [String:String]{
                for (key,value) in results  {
                    self.countries.append(value)
                }
                print(self.countries)
                
                    self.nationalityBtn.isHidden = false
                self.countriesDropDown.anchorView = self.nationalityBtn // UIView or UIBarButtonItem
                    self.countriesDropDown.dataSource = self.countries
                    self.nationalityBtn.setTitle(self.countries.first as? String ?? "", for: .normal)
                    self.nationality = self.countries.first!
                    self.countriesDropDown.width = self.nationalityBtn.frame.size.width
                    self.countriesDropDown.direction = .any
                    self.countriesDropDown.bottomOffset = CGPoint(x: 0, y:(self.countriesDropDown.anchorView?.plainView.bounds.height)!)
                    self.countriesDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                        print("Selected item: \(item) at index: \(index)")
                        self.nationalityBtn.setTitle("+\(self.countries[index])", for: .normal)
                        self.nationality = self.countries[index]
                        self.nationalityText.text = self.countries[index]
                        self.view.layoutIfNeeded()
                        //append child dropdown
                        print("\(self.countries[index])")
                        
                    }
            }
            print(self.countries)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
