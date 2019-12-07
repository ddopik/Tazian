//
//  MainScreenViewController.swift
//  barber
//
//  Created by amr sobhy on 2/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import DLRadioButton

class MainScreenViewController: UIViewController {
    @IBOutlet private weak var mapCenterPinImage: UIImageView!
    var checkedButton = 0
    @IBOutlet weak var startBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
         self.navigationController?.navigationBar.isHidden = true
        startBtn.ButtonborderRound()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startAction(_ sender: Any) {
        print("testSelected \(checkedButton)")
        if checkedButton == 1 {
              let viewOpen = self.storyboard?.instantiateViewController(withIdentifier: "loginView") as? LoginViewController
            self.navigationController?.pushViewController(viewOpen!, animated: true)
        }
        else if checkedButton == 2 || checkedButton == 3{
              let viewOpen = self.storyboard?.instantiateViewController(withIdentifier: "loginPhoneView") as? LoginPhoneViewController
            self.navigationController?.pushViewController(viewOpen!, animated: true)
        }
     }
    @IBAction func customerAction(_ sender: Any) {
        checkedButton = 1
        userType = 1
        node = "customers" 
    }
    
    @IBAction func shopAction(_ sender: Any) {
        checkedButton = 3
         userType = 3
        node = "shops"
    }
    
    @IBAction func barberAction(_ sender: Any) {
        checkedButton = 2
         userType = 2
        node = "barbers"
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
