//
//  PhoneNumberViewController.swift
//  barber
//
//  Created by amr sobhy on 2/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseDatabaseUI
import Toast
import MBProgressHUD
import DropDown
import Alamofire
class PhoneNumberViewController: UIViewController {
    var ref : DatabaseReference!
    
    override func viewDidLoad() {
         ref = Database.database().reference()
        super.viewDidLoad()
          self.navigationItem.title = "ادخل رقم الهاتف"
        sendNumberBtn.ButtonborderRoundradius(radius:10.0)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: navigationColorCode)
        get_countries()
    }

    @IBOutlet weak var phoneNumberText: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var sendNumberBtn: UIButton!
    
    @IBAction func sendNumberAction(_ sender: Any) {
        var phone = self.phoneNumberText.text
       
        guard (phone?.isPhoneNumber)! else {
            let alert = UIAlertController(title:"Validation",message :"Enter Valid phone number",preferredStyle:.alert)
            let cancel = UIAlertAction(title:"ok" , style:.cancel , handler : nil)
           
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            return
        }
        guard !(phone?.isEmpty)! else {
           let alert = UIAlertController(title:"Validation",message :"Enter Valid phone number",preferredStyle:.alert)
             let cancel = UIAlertAction(title:"ok" , style:.cancel , handler : nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            return
        }
      print("success")
        self.view.makeToast("\(phone)")
        let alert = UIAlertController(title:"Phone Number",message :"is this your phone number \n \(phone!)",preferredStyle:.alert)
        let action = UIAlertAction(title:"Yes",style:.default){(UIAlertAction) in
              MBProgressHUD.showAdded(to: self.view, animated: true)
            phone = "+\(self.phoneCodes[self.indexSelected])"+phone!
            PhoneAuthProvider.provider().verifyPhoneNumber(phone!, uiDelegate: nil) { (verificationID, error) in
                MBProgressHUD.hide(for: self.view, animated: true)
                if let error = error {
                    self.view.makeToast("Error Ocurred , please try again")
                    print(error.localizedDescription)
                    return
                }else{
                   
                    print("verificationId")
                    print(verificationID)
                    let defaults = UserDefaults.standard
                    defaults.setValue(verificationID, forKey: "phoneCode")
                    defaults.setValue(phone, forKey: "phoneNumber")
                    
                    self.performSegue(withIdentifier: "verifySegue", sender: nil)
                }
                // Sign in using the verificationID and the code sent to the user
                // ...
            }
        }
        let cancel = UIAlertAction(title:"no" , style:.cancel , handler : nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
        
    }
    var phoneCodes = [String]()
    var countriesName = [String]()
    @IBOutlet var cityBtn: UIButton!
    var phoneCodeDropDown = DropDown()
    var indexSelected = 0
    @IBAction func cityAction(_ sender: Any) {
        phoneCodeDropDown.show()
    }
    @IBOutlet weak var codeBtn: UIButton!
    func get_countries (){
        
        Alamofire.request("http://country.io/phone.json").responseJSON {
            (response) in
            if let results = response.result.value as? [String:String] {
                for country in results {
                    self.phoneCodes.append(country.value)
                }
            }
        }
        Alamofire.request("http://country.io/names.json").responseJSON {
            (response) in
            if let results = response.result.value as? [String:String] {
                for country in results {
                    self.countriesName.append(country.value)
                }
                
                self.phoneCodeDropDown.anchorView = self.cityBtn // UIView or UIBarButtonItem
                
                self.phoneCodeDropDown.dataSource = self.countriesName
                self.cityBtn.setTitle("\(self.countriesName[self.indexSelected])", for: .normal)
                self.phoneCodeDropDown.width = self.cityBtn.frame.size.width
                self.phoneCodeDropDown.direction = .any
                self.phoneCodeDropDown.bottomOffset = CGPoint(x: 0, y:(self.phoneCodeDropDown.anchorView?.plainView.bounds.height)!)
                self.phoneCodeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                    print("Selected item: \(item) at index: \(index)")
                    self.cityBtn.setTitle("\(self.countriesName[index])", for: .normal)
                    self.codeBtn.setTitle(self.phoneCodes[index], for: .normal)
                    self.indexSelected = index
                    
                    
                }
            }
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
