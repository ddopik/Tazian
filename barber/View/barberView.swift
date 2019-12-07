//
//  barberView.swift
//  barber
//
//  Created by amr sobhy on 3/25/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import MBCircularProgressBar
class barberView: UIView  {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet var imgViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var userLabel: UILabel!
    
    
    @IBOutlet weak var rateLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var prevBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var favouriteBtn: UIButton!
    
    @IBOutlet weak var locationBtn: UIButton!
    
    
    @IBOutlet var rateView: MBCircularProgressBarView!
    
    @IBOutlet var waitingView: MBCircularProgressBarView!
    
    
    @IBOutlet var priceView: MBCircularProgressBarView!
    
    @IBOutlet var downActionBtnStack: UIStackView!
    
    @IBOutlet var downActionBtnHeight: NSLayoutConstraint!
}
