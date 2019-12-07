//
//  invitationCodeViewController.swift
//  barber
//
//  Created by amr sobhy on 3/3/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI
import MBProgressHUD
import Toast
class invitationCodeViewController: UIViewController ,UIGestureRecognizerDelegate {

    @IBOutlet weak var pasteIcon: UIImageView!
    @IBOutlet weak var activationText: UITextField!
    @IBOutlet weak var checkBtn: UIButton!
    
    
    var ref:DatabaseReference!
    var databaseHandler : DatabaseHandle!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        activationText.TextborderRound()
        checkBtn.ButtonborderRound()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        let pasteRegonize = UITapGestureRecognizer(target: self, action: #selector(self.pasteAction(sender:)))
        self.pasteIcon.addGestureRecognizer(pasteRegonize)
        if let string = UIPasteboard.general.string {
            activationText.text = string
            // text was found and placed in the "string" constant
        }
    }
    @objc func pasteAction (sender:UITapGestureRecognizer) {
     
        
        if let string = UIPasteboard.general.string {
                activationText.text = string
            // text was found and placed in the "string" constant
        }
    }

    @IBAction func checkAction(_ sender: Any) {
        if(activationText.text != ""){
         MBProgressHUD.showAdded(to: self.view, animated: true)
            self.ref.child("users").child("shops").child(activationText.text!)
           
            print(activationText.text!)
            let databaseHandler = ref.child("users").child("shops").child(activationText.text!).observeSingleEvent(of: .value, with: {(snapshot) in
                
              print(snapshot.value)
                MBProgressHUD.hide(for: self.view, animated: true)
                if let shop_data = snapshot.value as? [String:AnyObject] {
                    print(shop_data)
                    UserDefaults.standard.set(shop_data, forKey: "shop_data")
                   /*
                    var shopSign = self.storyboard?.instantiateViewController(withIdentifier: "signUpBarberView") as? signUpBarberViewController
                    print("elf.shop_data\(shop_data)")
                    
                    shopSign?.shop_data = shop_data
                    
                    self.navigationController?.pushViewController(shopSign!, animated: true)
                    */
                    let viewOpen = self.storyboard?.instantiateViewController(withIdentifier: "phoneNumberView") as? PhoneNumberViewController
                    self.navigationController?.pushViewController(viewOpen!, animated: true)
                }else{
                    self.view.makeToast("Wrong Invitation Code")
                }
             })
            
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
