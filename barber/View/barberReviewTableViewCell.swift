//
//  barberReviewTableViewCell.swift
//  barber
//
//  Created by amr sobhy on 4/22/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class barberReviewTableViewCell: UITableViewCell ,FloatRatingViewDelegate{

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalReview: FloatRatingView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var waitingLabel: UILabel!
    
    
    @IBOutlet weak var priceReview: FloatRatingView!
    @IBOutlet weak var serviceReview: FloatRatingView!
    @IBOutlet weak var waitingReview: FloatRatingView!
    
    var parent : reviewListViewController!
    
    var reviewList = Dictionary<String,AnyObject> ()
    
    
    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
                nameLabel.text = reviewList["customerName"] as? String ?? ""
                dateLabel.text = convertTimestamp(serverTimestamp: reviewList["reviewdate"] as? Double ?? 0.0)
                commentLabel.text = reviewList["comment"] as? String ?? ""
                var total_review = Double(reviewList["price"] as? Double ?? 0.0) +  Double( reviewList["waiting"] as? Double ?? 0.0) + Double(reviewList["service"] as? Double ?? 0.0)
                
                var price = Double(reviewList["price"] as? String ?? "0.0") ?? 0.0
                var waiting = Double(reviewList["waiting"] as? String ?? "0.0") ?? 0.0
                var service = Double(reviewList["service"] as? String ?? "0.0") ?? 0.0
                totalReview.rating = Double(total_review / 3.0 )
                
                priceReview.rating = Double(reviewList["price"] as? Double ?? 0.0)
                priceLabel.text = "Price Rate"
                
                serviceReview.rating = Double(reviewList["service"] as? Double ?? 0.0)
                serviceLabel.text = "Service Rate"
                
                waitingReview.rating = Double(reviewList["waiting"] as? Double ?? 0.0)
                waitingLabel.text = "Waiting Rate"
                
                totalReview.setupFloatEdit(index: 0, editable: false, rate: total_review)
                priceReview.setupFloatEdit(index: 1, editable: false, rate: price)
                serviceReview.setupFloatEdit(index: 2, editable: false, rate: service)
                waitingReview.setupFloatEdit(index: 3, editable: false, rate: waiting)
                
                
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
