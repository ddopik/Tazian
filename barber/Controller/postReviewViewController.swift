//
//  postReviewViewController.swift
//  barber
//
//  Created by amr sobhy on 4/19/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import Firebase
import Toast
import MBProgressHUD
class postReviewViewController: UIViewController  ,FloatRatingViewDelegate {
    
   
    
    @IBOutlet weak var floatRatingView: FloatRatingView!
    //  @IBOutlet weak var arrivalReview: FloatRatingView!
    
    
    @IBOutlet weak var rateView2: FloatRatingView!
    // @IBOutlet weak var over: FloatRatingView!
    
    @IBOutlet weak var rateView3: FloatRatingView!
    var requestArray = [String:AnyObject]()
    
    @IBOutlet weak var imgUser: UIImageView!
    
    @IBOutlet weak var overallLabel: UILabel!
    @IBOutlet weak var behaviourLabel: UILabel!
    @IBOutlet weak var arrivalLabel: UILabel!
    var rate1 = "0"
    var rate2 = "0"
    var rate3 = "0"
    
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var ref:DatabaseReference!
    override func viewDidLoad() {
        //barberReviewed
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        if userType == 1 {
            nameLabel.text = requestArray["barberName"] as? String ?? ""
            emailLabel.text = requestArray["barberName"] as? String ?? ""
        }else{
              nameLabel.text = requestArray["customerName"] as? String ?? ""
             emailLabel.text = requestArray["customerName"] as? String ?? ""
        }
     
        ref = Database.database().reference()
      
        overallLabel.text = "Overall Rate"
        behaviourLabel.text = "Behaviour Rate"
        arrivalLabel.text = "Arrival Rate"
        postBtn.ButtonborderRoundradius(radius: 5)
        containerView.ViewborderRound(border: 0.2, corner: 7.0)
        
        floatRatingView.delegate = self
        rateView2.delegate = self
        rateView3.delegate = self
    
        floatRatingView.setupFloatEdit(index:0)
        rateView2.setupFloatEdit(index:1)
        rateView3.setupFloatEdit(index:2)
        
       
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func postAction(_ sender: Any) {
        var customerToBarber = ["barberID":requestArray["barberID"],"barberImageURL":requestArray["barberImageURL"],"barberName":requestArray["barberName"],
                                "barberToken":requestArray["barberToken"],"comment":self.reviewText.text,"customerID":requestArray["customerID"],"customerImageURL":requestArray["customerImageURL"],"customerName":requestArray["customerName"],"customerToken":requestArray["customerToken"],"price":rate1,"rate":rate2,"requestID":requestArray["requestID"],"reviewID":"","reviewdate":[".sv": "timestamp"],"service":rate3,"timeorder":[".sv": "timestamp"],"wating":""
            ] as [String : Any]
        
        var barberToCustomer =
            ["barberID":requestArray["barberID"],"barberImageURL":requestArray["barberImageURL"],"barberName":requestArray["barberName"], "barberToken":requestArray["barberToken"],"comment":self.reviewText.text,"customerID":requestArray["customerID"],
             "customerImageURL":requestArray["customerImageURL"],"customerName":requestArray["customerName"],"customerToken":requestArray["customerToken"],
             "behavior":rate1,"attendance":rate2,"requestID":requestArray["requestID"],"reviewID":"","reviewdate":[".sv": "timestamp"],
             "overall":rate3,"timeorder":[".sv": "timestamp"],"wating":""
                ] as [String : Any]
        print(userType)
        
        if userType == 1 {
            
            
            let reviewID = self.ref.child("reviews").child(node).child(userData["userID"] as? String ?? "").child("toOthers").childByAutoId().key
            customerToBarber["reviewID"] = reviewID
            self.ref.child("reviews").child("barbers").child(requestArray["barberID"] as? String ?? "").child("toYou").child(reviewID).setValue(customerToBarber)
            self.ref.child("reviews").child("customers").child(userData["userID"] as? String ?? "").child("toOther").child(reviewID).setValue(customerToBarber)
            
           }else{
            let reviewID = self.ref.child("reviews").child(node).child(userData["userID"] as? String ?? "").child("toOthers").childByAutoId().key
            customerToBarber["reviewID"] = reviewID
           
            self.ref.child("reviews").child("customers").child(requestArray["barberID"] as? String ?? "").child("toYou").child(reviewID).setValue(barberToCustomer)
            self.ref.child("reviews").child("barbers").child(userData["userID"] as? String ?? "").child("toOther").child(reviewID).setValue(barberToCustomer)
         }
        
        updateRequest()
        
    }
    func updateRequest(){
    
        var userID = userData["userID"] as? String ?? ""
        var barberComment = "This Request has marked as completed"
        let requestID = self.requestArray["requestID"]!
        let customerID = self.requestArray["customerID"]!
        let barberID = self.requestArray["barberID"]!
        var value_update = [String:AnyObject]()
        if userType == 1 {
            value_update = [
                "barberComment":barberComment as AnyObject,"customerReviewed":true as AnyObject,
                "customerComment":barberComment as AnyObject
            ]
        }else{
            value_update = [
                "barberComment":barberComment as AnyObject,"barberReviewed":true as AnyObject,
                "customerComment":barberComment as AnyObject
            ]
        }
        
        print("value_update\(value_update)")
        
        self.ref.child("requests").child("barbers").child(barberID as! String).child(requestID as! String).updateChildValues(value_update)
        self.ref.child("requests").child("customers").child(customerID as! String).child(requestID as! String).updateChildValues(value_update)
        self.view.makeToast("Answer Submitted")
       self.navigationController?.popViewController(animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
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
}
/*

extension postReviewViewController: FloatRatingViewDelegate {
    
    // MARK: FloatRatingViewDelegate
    
    func floatRatingView(_ ratingView: FloatRatingView, isUpdating rating: Double) {
       //liveLabel.text = String(format: "%.2f", self.floatRatingView.rating)
    }
 
    func floatRatingView(_ ratingView: FloatRatingView, didUpdate rating: Double) {
        //updatedLabel.text = String(format: "%.2f", self.floatRatingView.rating)
    }
    
}
*/

extension FloatRatingView {
    func setupFloatEdit (index:Int,editable:Bool = true ,rate:Double = 1.0) {
        
        self.backgroundColor = UIColor.clear
      self.tag = index
        self.contentMode = UIView.ContentMode.scaleAspectFit
       
        self.type = .halfRatings
        self.maxRating = 5
        self.minRating = 1
        self.rating = rate
        self.editable = editable
    }
}

