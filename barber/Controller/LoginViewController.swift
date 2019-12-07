//
//  LoginViewController.swift
//  barber
//
//  Created by amr sobhy on 2/24/18.
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

class LoginViewController: UIViewController , GIDSignInUIDelegate ,GIDSignInDelegate{
   
    
    
    

    @IBOutlet weak var phoneBtn: UIButton!
    
    @IBOutlet weak var googleBtn: UIButton!
    
    @IBOutlet weak var twitterBtn: UIButton!
    
    @IBOutlet weak var facebookBtn: UIButton!
    var ref : DatabaseReference!
    
    @IBOutlet weak var signInButton: GIDSignInButton!
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
         GIDSignIn.sharedInstance().uiDelegate = self
         self.navigationController?.navigationBar.isHidden = false
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: navigationColorCode)
    }
   
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
          MBProgressHUD.showAdded(to: self.view, animated: true)
         if let error = error {
           let alert = UIAlertController(title:"Validation",message :"Error Occured \n \(error.localizedDescription)",preferredStyle:.alert)
            let cancel = UIAlertAction(title:"ok" , style:.cancel , handler : nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            return
        }
         let idToken = user.authentication.idToken // Safe to send to the server
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            print("User Signed Into Firebase")
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
               
                let email = user?.email ?? ""
                
                let databaseHandler = self.ref.child("users").child("customers").queryOrdered(byChild: "email").queryStarting(atValue: email).queryEnding(atValue: "\(email) \u{f8ff}").observeSingleEvent(of: .value, with: {(snapshot) in
                    if let user_data = snapshot.value as? [String:AnyObject]  {
                        print("user_data\(user_data)")
                       userData = user_data.first!.value as? [String : AnyObject] ?? [:]
                        saveUserData(userData: userData )
                        let masterScreen = self.storyboard?.instantiateViewController(withIdentifier: "masterHomeView") as? masterHomeViewController
                        self.present(masterScreen!, animated: true, completion: nil)
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }else{
                        print("snapshot.value\(snapshot.value)")
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.view.makeToast("No Such User Found \n try again ")
                    }
                })
                { (err) in
                    print(err)
                  MBProgressHUD.hide(for: self.view, animated: true)
                    self.view.makeToast("Error Occured \n \(err.localizedDescription)")
                }
        
        }
            
        }
       
       
        // ...
    }
 
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
 
    @IBAction func loginAction(_ sender: Any) {
        let viewOpen = self.storyboard?.instantiateViewController(withIdentifier: "phoneNumberView") as? PhoneNumberViewController
        loginType = 0 
        self.navigationController?.pushViewController(viewOpen!, animated: true)
    }
    @IBAction func googleAction(_ sender: Any) {
          social = "google"
        loginType = 0
        GIDSignIn.sharedInstance().signIn()
}
    func firebaseSignIn(){
        
    }
    @IBAction func twitterAction(_ sender: Any) {
        loginType = 0

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
        loginType = 0

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
                else{
                    
                   let email = user?.email ?? ""
                    let databaseHandler = self.ref.child("users").child("customers").queryOrdered(byChild: "email").queryStarting(atValue: email).queryEnding(atValue: "\(email) \u{f8ff}").observeSingleEvent(of: .value, with: {(snapshot) in
                        if let user_data = snapshot.value as? [String:AnyObject]  {
                           
                            
                            saveUserData(userData: user_data.first!.value as! [String : AnyObject])
                             userData = user_data.first!.value as? [String : AnyObject] ?? [:]
                            MBProgressHUD.hide(for: self.view, animated: true)
                            self.view.makeToast("Welcome Back \n \(email) ")
                            let masterScreen = self.storyboard?.instantiateViewController(withIdentifier: "masterHomeView") as? masterHomeViewController
                            self.navigationController?.pushViewController(masterScreen!, animated: true)
                            
                        }else{
                            print("snapshot.value\(snapshot.value)")
                            MBProgressHUD.hide(for: self.view, animated: true)
                            self.view.makeToast("No Such User Found \n try again ")
                        }
                    })
                    { (err) in
                        print(err)
                        MBProgressHUD.hide(for: self.view, animated: true)
                        self.view.makeToast("Error Occured \n \(err.localizedDescription)")
                    }
                    
                }
                
            })
            
            
            
        }
   }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

}
