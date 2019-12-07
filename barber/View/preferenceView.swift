//
//  preferenceView.swift
//  barber
//
//  Created by amr sobhy on 5/25/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class preferenceView: UIView {

    @IBOutlet weak var switchBtn: UISwitch!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var subLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn == true {
            self.segment.isEnabled = true
        }else{
            self.segment.isEnabled = false
        }
    }
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBAction func segmentAction(_ sender: Any) {
        
    }
    
}
