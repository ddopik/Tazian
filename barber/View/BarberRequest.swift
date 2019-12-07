//
//  BarberRequest.swift
//  barber
//
//  Created by amr sobhy on 3/27/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class BarberRequest: UITableViewCell {

    
    // Mark Customer on agree can see chat button only but barber can see (chat , mark as complete , didn"t show up which mean cancel request).
    // Question view is still appear until barber or customer select agree button then it hide for both.
    var requestId :String!
    
    
    @IBOutlet weak var agreeViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var barberLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var declineBtn: UIButton!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!
    
    @IBOutlet weak var agreeView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var firstQuestionBtn: UIButton!
    @IBOutlet weak var secondQuestionBtn: UIButton!
    @IBOutlet weak var thirdQuestionBtn: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var barberCompleteRequest: UIStackView!
    @IBOutlet weak var stackAcceptDecline: UIStackView!
    
    @IBOutlet weak var topseperateView: UIView!
    
    @IBOutlet weak var bottomSeperateView: UIView!
    /*
     120
     // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       self.containerView.ViewborderRound(border: 0.3, corner: 20)
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}

