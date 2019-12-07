//
//  profileTopTableViewCell.swift
//  barber
//
//  Created by amr sobhy on 3/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class profileTopTableViewCell: UITableViewCell ,FloatRatingViewDelegate {

    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var firstView: UIView!
    
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet weak var firstRate: FloatRatingView!
    
    @IBOutlet weak var secondRate: FloatRatingView!
    
    @IBOutlet weak var thirdRate: FloatRatingView!
    var rate1 = "1"
    var rate2 = "2"
    var rate3 = "3"
    @IBOutlet weak var allRate: FloatRatingView!

    @IBOutlet var changeBtn: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        firstView.ViewborderRound(border: 0.4, corner: 10)
        secondView.ViewborderRound(border: 0.4, corner: 10)
        thirdView.ViewborderRound(border: 0.4, corner: 10)
        // Initialization code
        
        firstRate.delegate = self
        secondRate.delegate = self
        thirdRate.delegate = self
        allRate.delegate = self
        firstRate.setupFloatEdit(index:0)
        secondRate.setupFloatEdit(index:1)
        thirdRate.setupFloatEdit(index:2)
        allRate.setupFloatEdit(index: 4)
        changeBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        changeBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
    }
    
    
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Float){
        
        if ratingView.tag == 0 {
            rate1  = String(format: "%.2f", ratingView.rating)
        } else if ratingView.tag == 1 {
            rate2  = String(format: "%.2f", ratingView.rating)
        }else if ratingView.tag == 2 {
            rate3  = String(format: "%.2f", ratingView.rating)
        }
        print("rating Edit \(ratingView.tag) \(String(format: "%.2f", ratingView.rating))")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
