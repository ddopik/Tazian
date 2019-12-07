//
//  VerificationCodeViewController.swift
//  barber
//
//  Created by amr sobhy on 2/25/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import Toast
import MBProgressHUD
import FirebaseDatabaseUI

class VerificationCodeViewController: UIViewController {
    var ref : DatabaseReference!
    var databaseHandler : DatabaseHandle!
     let defaults = UserDefaults.standard
    var phone = ""
    
    @IBOutlet weak var phoneViewBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        phone  = (self.defaults.value(forKey: "phoneNumber") as? String)!
        phoneViewBtn.setTitle(phone, for: .normal)
        phoneViewBtn.ButtonborderRound()       
        // Do any additional setup after loading the view.
        self.loginBtn.ButtonborderRoundradius(radius: 5)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: navigationColorCode)
    }
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var verificationCode: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        MBProgressHUD.showAdded(to: self.view, animated: true)
       
        var phoneCode = defaults.value(forKey: "phoneCode")
        
        self.phone = defaults.value(forKey: "phoneNumber") as? String ?? ""
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: phoneCode as! String,
            verificationCode: verificationCode.text!)
        print(credential)
        print("testwork")
        Auth.auth().signIn(with: credential) { (user, error) in
              MBProgressHUD.hide(for: self.view, animated: true)
            if let error = error {
                // ...
                 print(error.localizedDescription)
                 print("localizedDescription")
                let alert = UIAlertController(title:"Validation",message :"The SMS verification code used to create the phone auth credential is invalid. Please resend the verification code SMS and be sure to use the verification code",preferredStyle:.alert)
                let action = UIAlertAction(title:"Resend Code",style:.default){(UIAlertAction) in
                    MBProgressHUD.showAdded(to: self.view, animated: true)
                    print("phone again \(self.phone)")
                    PhoneAuthProvider.provider().verifyPhoneNumber(self.phone) { (verificationID, error) in
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
                        }
                        // Sign in using the verificationID and the code sent to the user
                        // ...
                    }
                }
                 let cancel = UIAlertAction(title:"No" , style:.cancel , handler : nil)
                alert.addAction(action)
                  alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
              
                self.view.makeToast("Error occured")
                return
            }else{
               print(loginType)
                print(userType)
                
                self.view.makeToast("Successfully Registered")
                // Mark to check whether login or signup process
                if loginType == 0 {
                    /*databaseHandler = self.ref.child("users").child("barbers").queryOrdered(byChild:  "phone").queryStarting(atValue: strSearch).queryEnding(atValue: strSearch + "\u{f8ff}").*/
                    
                    let databaseHandler = self.ref.child("users").child(node).queryOrdered(byChild: "phone").queryStarting(atValue: self.phone).queryEnding(atValue: "\(self.phone) \u{f8ff}").observeSingleEvent(of: .value, with: {(snapshot) in
                        if let user_data = snapshot.value as? [String:AnyObject]  {
                          
                            
                            userData = user_data.first!.value as? [String : AnyObject] ?? [:]
                             print("user_data\(userData)")
                            saveUserData(userData: userData)
                            loadUserData()
                            
                            let masterScreen = self.storyboard?.instantiateViewController(withIdentifier: "masterHomeView") as? masterHomeViewController
                            self.navigationController?.pushViewController(masterScreen!, animated: true)
                        }else{
                            self.view.makeToast("There is no such user")
                        }
                    })
                    { (err) in
                        self.view.makeToast("There is no such user")
                        print(err)
                    }
                } else {
                    let userId = user?.uid as? String ?? ""

                    if userType == 1 {
                        
                        print(userId)
                        //shopsignUpView
                        var newUserClass = User.init(attendance: 0.0, attendanceCount: 0, behavior: 0.0, behaviorCount: 0, email: "", fullname: "", imageURL: "", isOnline: true, membersince: [".sv": "timestamp"] as AnyObject, nationality: "", overallRating: 0.0, overallRatingCount: 0, phone: self.phone as! String, token: token, type: userType, userID: userId, username:"")
                        var newUser = newUserClass?.getData()
                        
                        print(newUser)
                        print("testNewUSer")
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.ref.child("users").child("customers").child(userId).setValue(newUser)
                        
                        saveUserData(userData: newUser!)
                        loadUserData()

                        let masterScreen = self.storyboard?.instantiateViewController(withIdentifier: "masterHomeView") as? masterHomeViewController
                        self.navigationController?.pushViewController(masterScreen!, animated: true)
                    }
                    else if userType == 3 {
                        var mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "shopsignUpView") as? shopsignUpViewController
                        mainScreen?.phone = self.phone as! String
                        print("self.phone\(self.phone)")
                        
                        self.navigationController?.pushViewController(mainScreen!, animated: true)
                    }
                    else if userType == 2 {
                        var shopSign = self.storyboard?.instantiateViewController(withIdentifier: "signUpBarberView") as? signUpBarberViewController
                        shopSign?.userId = userId
                        UserDefaults.standard.set(self.phone, forKey: "phone")
                        
                        self.navigationController?.pushViewController(shopSign!, animated: true)
                    }
                }
               
                
            }
            // User is signed in
            // ...
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
