//
//  FavouriteTableViewCell.swift
//  barber
//
//  Created by amr sobhy on 4/1/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var barberName: UILabel!
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
