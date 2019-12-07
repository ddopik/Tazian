//
//  listViewTableViewCell.swift
//  barber
//
//  Created by amr sobhy on 4/27/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class listViewTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var conatinerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        conatinerView.layer.cornerRadius = 15.0
        conatinerView.layer.borderColor = UIColor.clear.cgColor
        conatinerView.layer.borderWidth = 1.0
        conatinerView.ViewdropShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
