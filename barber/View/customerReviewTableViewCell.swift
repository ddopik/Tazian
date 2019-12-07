//
//  customerReviewTableViewswift
//  barber
//
//  Created by amr sobhy on 4/22/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class customerReviewTableViewCell: UITableViewCell ,FloatRatingViewDelegate {

    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var totalReview: FloatRatingView!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBOutlet weak var behaviourLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
  
    
    
    @IBOutlet weak var behaviourReview: FloatRatingView!
    @IBOutlet weak var arrivalReview: FloatRatingView!
    
    
    @IBOutlet weak var containerView: UIView!
    var parent : reviewListViewController!
    var reviewList = Dictionary<String,AnyObject> ()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if userType == 1 {
            nameLabel.text = reviewList["barberName"] as? String ?? ""
            dateLabel.text = convertTimestamp(serverTimestamp: reviewList["timeorder"] as? Double ?? 0.0)
            commentLabel.text = reviewList["comment"] as? String ?? ""
            
            let price = Double(reviewList["price"] as? String ?? "0.0") ?? 0.0
            let rate = Double(reviewList["rate"] as? String ?? "0.0") ?? 0.0
            let total_review = price + rate
            totalReview.setupFloatEdit(index: 0, editable: false, rate: Double(total_review / 2.0 ))
            arrivalLabel.text = "Price Rate"
            arrivalReview.setupFloatEdit(index: 1, editable: false, rate: price)
            behaviourLabel.text = "Service Rate"
            behaviourReview.setupFloatEdit(index: 2, editable: false, rate: rate)
        }else{
            
                nameLabel.text = reviewList["barberName"] as? String ?? ""
                dateLabel.text = convertTimestamp(serverTimestamp: reviewList["reviewdate"] as? Double ?? 0.0)
                commentLabel.text = reviewList["comment"] as? String ?? ""
                var total_review = Double( reviewList["price"] as? Double ?? 0.0 ) +  Double( reviewList["rate"] as? Double ?? 0.0 )
                print("total_review\(total_review)")
                print("reviewList\(Double(reviewList["price"] as? Double ?? 0.0))")
                
                totalReview.rating = Double(total_review / 2.0 )
                
                behaviourReview.rating = Double(reviewList["price"] as? Double ?? 0.0)
                behaviourLabel.text = "Price Rate"
                
                behaviourReview.rating = Double(reviewList["service"] as? Double ?? 0.0)
                behaviourLabel.text = "Service Rate"
               
        }
        
        
        containerView.ViewborderRound(border: 0.2, corner: 8)
       
         
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
