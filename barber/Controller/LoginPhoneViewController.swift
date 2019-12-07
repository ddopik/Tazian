//
//  LoginPhoneViewController.swift
//  barber
//
//  Created by amr sobhy on 2/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import FirebaseAuthUI
import Toast
import MBProgressHUD

class LoginPhoneViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        phoneBtn.ButtonborderRound()
      
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: navigationColorCode)
    }

    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var phoneBtn: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signupAction(_ sender: Any) {
        loginType =  1
        if userType == 3 {
            let viewOpen = self.storyboard?.instantiateViewController(withIdentifier: "phoneNumberView") as? PhoneNumberViewController
            self.navigationController?.pushViewController(viewOpen!, animated: true)
        }
        else if userType == 2 {
            let viewOpen = self.storyboard?.instantiateViewController(withIdentifier: "invitationCodeView") as? invitationCodeViewController
            self.navigationController?.pushViewController(viewOpen!, animated: true)
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        loginType = 0
        let viewOpen = self.storyboard?.instantiateViewController(withIdentifier: "phoneNumberView") as? PhoneNumberViewController
        self.navigationController?.pushViewController(viewOpen!, animated: true)
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
