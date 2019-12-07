//
//  settingCellTableViewCell.swift
//  barber
//
//  Created by amr sobhy on 3/27/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class settingCellTableViewCell: UITableViewCell {

    @IBOutlet weak var settingImg: UIImageView!
    @IBOutlet weak var actionBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
