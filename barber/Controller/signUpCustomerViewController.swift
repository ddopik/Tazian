//
//  signUpCustomerViewController.swift
//  barber
//
//  Created by amr sobhy on 3/3/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class signUpCustomerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.ButtonborderRoundradius(radius: 17)
        pickBtn.ButtonborderRoundradius(radius: 17)
        firstNameText.TextborderRound()
        lastNameText.TextborderRound()
         CountryText.placeholderColor()
        firstNameText.placeholderColor()
         lastNameText.placeholderColor()
         CountryText.placeholderColor()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pickBtn: UIButton!
    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText : UITextField!
    @IBOutlet weak var CountryText : UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func nextAction(_ sender: Any) {
    }
    @IBAction func pickAction(_ sender: Any) {
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
