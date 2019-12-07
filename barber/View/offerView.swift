//
//  offerView.swift
//  barber
//
//  Created by amr sobhy on 5/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class offerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    
    @IBOutlet weak var discountImage: UIImageView!
}
