//
//  signUpCustomerViewController.swift
//  barber
//
//  Created by amr sobhy on 3/3/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseAuthUI
import FBSDKLoginKit
import FirebaseDatabaseUI
import GoogleSignIn
import TwitterKit
import MBProgressHUD
import Toast
class mainSignUpCustomerViewController: UIViewController ,GIDSignInDelegate ,GIDSignInUIDelegate{

    
    
    @IBOutlet weak var phoneBtn: UIButton!
    
    @IBOutlet weak var googleBtn: UIButton!
    
    @IBOutlet weak var twitterBtn: UIButton!
    
    @IBOutlet weak var facebookBtn: UIButton!
    var ref : DatabaseReference!
    
 
    @IBOutlet var twitterLoginView: TWTRLogInButton!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        
        self.phoneBtn.ButtonborderRound()
        self.googleBtn.ButtonborderRound()
        self.twitterBtn.ButtonborderRound()
        self.facebookBtn.ButtonborderRound()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        self.navigationController?.navigationBar.isHidden = false
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: navigationColorCode)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        loginType = 1

        MBProgressHUD.showAdded(to: self.view, animated: true)
        // ...
        if let error = error {
            // ...
            
            let alert = UIAlertController(title:"Validation",message :"Error Occured \n \(error.localizedDescription)",preferredStyle:.alert)
            let cancel = UIAlertAction(title:"ok" , style:.cancel , handler : nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = signIn.currentUser.profile.email
        print(signIn.currentUser)
        let imageUrl  = "\(user.profile.imageURL(withDimension: 200))"
        print("bynaty")
        print(user)
        print("bynatyEnd")
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.makeToast("Error Occured \n \(error.localizedDescription)")
                return
            }else{
                var newUserClass = User.init(attendance: 0.0, attendanceCount: 0, behavior: 0.0, behaviorCount: 0, email: email!, fullname: fullName!, imageURL: "", isOnline: true, membersince: [".sv": "timestamp"] as AnyObject, nationality: "", overallRating: 0.0, overallRatingCount: 0, phone: "", token: idToken!, type: userType, userID: userId!, username: givenName!)
                var newUser = newUserClass?.getData()
                print(newUser)
                print("testNewUSer")
                
                self.ref.child("users").child(node).child(userId!).setValue(newUser)
                saveUserData(userData: newUser! )
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.makeToast("Successfully Registered")
                let masterScreen = self.storyboard?.instantiateViewController(withIdentifier: "masterHomeView") as? masterHomeViewController
                self.navigationController?.pushViewController(masterScreen!, animated: true)
            }
        })
       
        // ...
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
    @IBAction func googleAction(_ sender: Any) {
        social = "google"
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        
        
    }
    func firebaseSignIn(){
        
    }
    @IBAction func twitterAction(_ sender: Any) {
        loginType = 1

        let twitterSignInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                let authToken = session?.authToken
                let authTokenSecret = session?.authTokenSecret
                print("whyyyyyyyy")
                let credential = TwitterAuthProvider.credential(withToken: (session?.authToken)!, secret: (session?.authTokenSecret)!)
                print(credential)
            }else {
                print("error: \(error?.localizedDescription)");
            }
            
            print("whyyyyyyyy")
            
            if (error != nil) {
                print("Twitter authentication failed")
            } else {
                guard let token = session?.authToken else {return}
                guard let secret = session?.authTokenSecret else {return}
                let credential = TwitterAuthProvider.credential(withToken: token, secret: secret)
                Auth.auth().signIn(with: credential, completion: { (user, error) in
                    if error == nil {
                        print("Twitter authentication succeed")
                    } else {
                        print("Twitter authentication failed")
                    }
                })
            }
        })
        
    }
    
    
    @IBAction func facebookAction(_ sender: Any) {
        loginType = 1

        MBProgressHUD.showAdded(to: self.view, animated: true)
        social = "facebook"
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email", "public_profile", "user_photos"], from: self) { (result, error) in
            if let error = error {
                let alert = UIAlertController(title:"Validation",message :"Failed to get access token \n \(error.localizedDescription)",preferredStyle:.alert)
                let cancel = UIAlertAction(title:"ok" , style:.cancel , handler : nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                MBProgressHUD.hide(for: self.view, animated: true)
                return
            }
            guard let accessToken = FBSDKAccessToken.current() else {
                
                let alert = UIAlertController(title:"Validation",message :"Failed to get access token \n \(error?.localizedDescription)",preferredStyle:.alert)
                let cancel = UIAlertAction(title:"ok" , style:.cancel , handler : nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                MBProgressHUD.hide(for: self.view, animated: true)
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print("Login error: \(error.localizedDescription)")
                    self.view.makeToast("Error Occured \n  \(error.localizedDescription)")
                    
                    return
                }
                print("userDetails\(user)")
                 print("enduserDetails")
                
                let userId = user?.uid
                let idToken = accessToken.tokenString
                let fullName = user?.displayName
                let imageUrl = "\(user?.photoURL!)"
                let phoneNumber = user?.phoneNumber ?? ""
                let email = user?.email
                
                var newUserClass = User.init(attendance: 0.0, attendanceCount: 0, behavior: 0.0, behaviorCount: 0, email: email!, fullname: fullName!, imageURL: imageUrl, isOnline: true, membersince: [".sv": "timestamp"] as AnyObject, nationality: "", overallRating: 0.0, overallRatingCount: 0, phone: phoneNumber, token: idToken!, type: userType, userID: userId!, username: fullName!)
                var newUser = newUserClass?.getData()
                print(newUser)
                print("testNewUSer")
                saveUserData(userData: newUser!)
                self.ref.child("users").child(node).child(userId!).setValue(newUser)
                MBProgressHUD.hide(for: self.view, animated: true)
                 self.view.makeToast("Successfully Registered")
                let masterScreen = self.storyboard?.instantiateViewController(withIdentifier: "masterHomeView") as? masterHomeViewController
                self.navigationController?.pushViewController(masterScreen!, animated: true)
               
                
            })
            MBProgressHUD.hide(for: self.view, animated: true)
            
            
        }
    }

    @IBAction func phoneAction(_ sender: Any) {
        let viewOpen = self.storyboard?.instantiateViewController(withIdentifier: "phoneNumberView") as? PhoneNumberViewController
        loginType = 1
        self.navigationController?.pushViewController(viewOpen!, animated: true)
    }
    
}
