//
//  profileDataTableViewCell.swift
//  barber
//
//  Created by amr sobhy on 3/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class profileDataTableViewCell: UITableViewCell {
   
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var fullnameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var addressText: UITextField!
    
     var parent : profileViewController!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.usernameText.TextborderRound(borderWidth: 0)
        self.fullnameText.TextborderRound(borderWidth: 0)
        self.phoneText.TextborderRound(borderWidth: 0)
        self.cityText.TextborderRound(borderWidth: 0)
        self.addressText.TextborderRound(borderWidth: 0)
        
        self.updateBtn.ButtonborderRoundradius(radius: 7)
        containerView.ViewborderRound(border: 0.4, corner: 20)
        
    }

    @IBOutlet weak var containerView: UIView!
    @IBAction func updateAction(_ sender: Any) {
        
        let userID = userData["userID"] as? String ?? ""
       let value_update = [
            "fullname":fullnameText.text as AnyObject,"username":usernameText.text as AnyObject,
        ]
        var node = ""
        if userType == 1 {
            node = "customers"
        }
        else if userType == 2 {
            node = "barbers"
        }
        else if userType == 3 {
            node = "shops"
        }
        self.parent.ref.child("users").child(node).child(userID as? String ?? "" ).updateChildValues(value_update)
        self.parent.view.makeToast("Updated")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
