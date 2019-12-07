//
//  barberRequestsViewController.swift
//  barber
//
//  Created by amr sobhy on 3/27/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import Firebase
import Toast
import MBProgressHUD

class barberRequestsViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource , FloatRatingViewDelegate{
    var ref : DatabaseReference!
    var databaseHandler: DatabaseHandle!
    var status = "requests"
    //Request Values :
    var barberRequestsArray = [Dictionary<String,AnyObject>]()
    var requestCompleted : Bool!
    var value_update :[String:AnyObject]!
    // End
    
    
    var selectedBarberRequest = ""
    var selectedBarberIndex = 0
    //Review Values
    var reviewList = [Dictionary<String,AnyObject>]()
    var reviewType = 0
    //End
    
    @IBOutlet weak var barberRequectTableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(barberRequestsArray.count)
        if status == "review" {
            return reviewList.count
        }else{
            
        return barberRequestsArray.count
    
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if status == "review" {
            return 190
        }else{
            let padding = CGFloat(20)
            let agreeViewHeight = CGFloat(100)
            let acceptDeclineHeight = CGFloat(40)
            let chatBtnHeight = CGFloat(40)
            let base_height = CGFloat(130)
            let questionView = CGFloat(100)
            
            if barberRequestsArray[indexPath.row]["agree"] as? Bool == true  {
                if barberRequestsArray[indexPath.row]["complete"] as? Bool == true {
                    return base_height - padding + chatBtnHeight
                }
                else if barberRequestsArray[indexPath.row]["canceled"] as? Bool == true {
                    return base_height - padding
                    
                }else if barberRequestsArray[indexPath.row]["customerNotShow"] as? Bool == true {
                    return base_height + padding
                }else{
                    if userType == 1 {
                        return base_height + agreeViewHeight + padding
                    }else{
                        return base_height + agreeViewHeight + padding
                    }
                }
                
            }
            else if barberRequestsArray[indexPath.row]["canceled"] as? Bool == true {
                return base_height - padding
            }
            else {
                if userType == 1 {
                    if barberRequestsArray[indexPath.row]["customerChangeTime"] as? Bool == true  {
                        return base_height + acceptDeclineHeight + questionView
                    }
                    else{
                        return base_height + acceptDeclineHeight
                    }
                }else{
                    if barberRequestsArray[indexPath.row]["barberChangeTime"] as? Bool == true  {
                        return base_height + acceptDeclineHeight + questionView
                    }
                    else{
                        return base_height + acceptDeclineHeight
                    }
                }
            }
        }
       
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if status == "review" {
            if userType == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "customerReviewTableViewCell") as? customerReviewTableViewCell
                cell?.reviewList = reviewList[indexPath.row]
                cell?.selectionStyle = .none
                cell?.totalReview.delegate = self
                cell?.arrivalReview.delegate = self
                cell?.behaviourReview.delegate = self
                return cell!
            }else {
                if reviewType == 0 {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "barberReviewTableViewCell") as! barberReviewTableViewCell
                    cell.selectionStyle = .none
                    cell.reviewList = reviewList[indexPath.row]
                    
                    cell.totalReview.delegate = self
                    cell.priceReview.delegate = self
                    cell.serviceReview.delegate = self
                    cell.waitingReview.delegate = self
                    return cell
                }else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "customerReviewTableViewCell") as! customerReviewTableViewCell
                    cell.reviewList = reviewList[indexPath.row]
                    
                    cell.totalReview.delegate = self
                    cell.arrivalReview.delegate = self
                    cell.behaviourReview.delegate = self
                    
                    return cell
                }
                
            }
        }else{
            
        
        let barberRequestNew = tableView.dequeueReusableCell(withIdentifier: "BarberRequest", for: indexPath) as!
        BarberRequest
        
        
        //remove all targe
        barberRequestNew.chatBtn.removeTarget(self, action: #selector(self.Review(sender:)), for: .touchUpInside)
        
        // End remove targets
        barberRequestNew.selectionStyle = .none
        //default status
        barberRequestNew.agreeView.isHidden = true
        barberRequestNew.questionView.isHidden = true
        barberRequestNew.chatBtn.isHidden = true
        barberRequestNew.layer.backgroundColor = UIColor.clear.cgColor
        barberRequestNew.contentView.backgroundColor = UIColor.clear
        barberRequestNew.containerView.backgroundColor = UIColor(hexString: "#ebebeb")
        //barberRequestNew.contentView.frame = CGRect(x:5,y:10,width: barberRequestNew.bounds.width - 10.0 ,height :barberRequestNew.bounds.height - 20.0  )
        
        
        barberRequestNew.agreeBtn.isEnabled = false
        barberRequestNew.declineBtn.isEnabled = false
        //default status end
        barberRequestNew.statusLabel.isHidden = true
        var titleName = (userType == 1) ? barberRequestsArray[indexPath.row]["barberName"] as? String ?? "" : barberRequestsArray[indexPath.row]["customerName"] as? String ?? ""
        
        var commentName = (userType == 1) ? barberRequestsArray[indexPath.row]["barberComment"] as? String ?? "" : barberRequestsArray[indexPath.row]["customerComment"] as? String ?? ""
        
        barberRequestNew.barberLabel.text = titleName
        barberRequestNew.dateLabel.text = convertTimestamp(serverTimestamp: barberRequestsArray[indexPath.row]["requestTime"] as? Double ?? 0.0)
        barberRequestNew.commentLabel?.text = "\(commentName) "
        barberRequestNew.requestId = barberRequestsArray[indexPath.row]["requestID"] as? String ?? ""
        if barberRequestsArray[indexPath.row]["agree"] as? Bool == true  {
            barberRequestNew.questionView.isHidden = true
            barberRequestNew.agreeBtn.isEnabled = false
            barberRequestNew.chatBtn.tag = indexPath.row
            barberRequestNew.barberCompleteRequest.isHidden = false
            barberRequestNew.stackAcceptDecline.isHidden = false
            barberRequestNew.topseperateView.isHidden = true
            barberRequestNew.bottomSeperateView.isHidden = true
            if userType == 1 {
                
                barberRequestNew.chatBtn.isEnabled = true
                barberRequestNew.chatBtn.setTitle("Chat", for: .normal)
                barberRequestNew.chatBtn.removeTarget(self, action: #selector(self.Review), for: .touchUpInside)
                if barberRequestsArray[indexPath.row]["complete"] as? Bool == true {
                    //   yourHeightConstraintOutlet.constant = someValue
                    //hide view section
                    barberRequestNew.barberCompleteRequest.isHidden = true
                    barberRequestNew.stackAcceptDecline.isHidden = true
                    
                    barberRequestNew.agreeViewConstraint.constant = 40
                    barberRequestNew.agreeView.layoutIfNeeded()
                    barberRequestNew.agreeView.isHidden = false
                    barberRequestNew.chatBtn.isHidden = false
                    
                    
                    if barberRequestsArray[indexPath.row]["customerReviewed"] as? Bool == true {
                        barberRequestNew.chatBtn.setTitle("Your Review has been posted", for: .normal)
                        barberRequestNew.chatBtn.isEnabled = false
                    }else{
                        barberRequestNew.chatBtn.addTarget(self, action: #selector(self.Review), for: .touchUpInside)
                        barberRequestNew.chatBtn.setTitle("Review", for: .normal)
                        barberRequestNew.chatBtn.isEnabled = true
                        
                    }
                }
                else if barberRequestsArray[indexPath.row]["canceled"] as? Bool == true {
                    //hide view section
                    barberRequestNew.barberCompleteRequest.isHidden = true
                    barberRequestNew.stackAcceptDecline.isHidden = true
                    barberRequestNew.agreeView.isHidden = true
                    
                    barberRequestNew.containerView.backgroundColor = UIColor(hexString: "#ebebeb")
                    
                }else if barberRequestsArray[indexPath.row]["customerNotShow"] as? Bool == true {
                    
                    
                    barberRequestNew.stackAcceptDecline.isHidden  = true
                    barberRequestNew.barberCompleteRequest.isHidden = true
                    barberRequestNew.agreeView.isHidden = true
                    barberRequestNew.containerView.backgroundColor = UIColor.lightGray
                    
                }
                else{
                    barberRequestNew.agreeViewConstraint.constant = 90
                    barberRequestNew.agreeView.layoutIfNeeded()
                    barberRequestNew.agreeView.isHidden = false
                    barberRequestNew.chatBtn.addTarget(self, action: #selector(self.chat), for: .touchUpInside)
                    barberRequestNew.chatBtn.isHidden = false
                    barberRequestNew.declineBtn.isEnabled = true
                    barberRequestNew.completeBtn.addTarget(self, action: #selector(self.completeRequest(sender:)), for: .touchUpInside)
                    
                    barberRequestNew.cancelBtn.addTarget(self, action: #selector(self.cancelRequest(sender:)), for: .touchUpInside)
                }
                
            }else{
                if barberRequestsArray[indexPath.row]["complete"] as? Bool == true {
                    barberRequestNew.barberCompleteRequest.isHidden = true
                    barberRequestNew.stackAcceptDecline.isHidden = true
                    
                    barberRequestNew.agreeViewConstraint.constant = 40
                    barberRequestNew.agreeView.layoutIfNeeded()
                    barberRequestNew.agreeView.isHidden = false
                    barberRequestNew.chatBtn.isHidden = false
                    
                    if barberRequestsArray[indexPath.row]["barberReviewed"] as? Bool == true {
                        barberRequestNew.chatBtn.setTitle("Your Review has been posted", for: .normal)
                        barberRequestNew.chatBtn.isEnabled = false
                    }else{
                        barberRequestNew.chatBtn.addTarget(self, action: #selector(self.Review), for: .touchUpInside)
                        barberRequestNew.chatBtn.setTitle("Review", for: .normal)
                    }
                }
                else if barberRequestsArray[indexPath.row]["canceled"] as? Bool == true {
                    
                    barberRequestNew.agreeBtn.isEnabled = false
                    barberRequestNew.declineBtn.isEnabled = false
                    barberRequestNew.stackAcceptDecline.isHidden  = true
                    barberRequestNew.topseperateView.isHidden = true
                    barberRequestNew.bottomSeperateView.isHidden = true
                    barberRequestNew.containerView.backgroundColor = UIColor(hexString: "#ebebeb")
                    
                }
                else if barberRequestsArray[indexPath.row]["customerNotShow"] as? Bool == true {
                    
                    barberRequestNew.agreeBtn.isEnabled = false
                    barberRequestNew.declineBtn.isEnabled = false
                    barberRequestNew.stackAcceptDecline.isHidden  = true
                    
                    barberRequestNew.containerView.backgroundColor = UIColor(hexString: "#ebebeb")
                    barberRequestNew.topseperateView.isHidden = true
                    barberRequestNew.bottomSeperateView.isHidden = true
                }
                else{
                    
                    barberRequestNew.agreeViewConstraint.constant = 90
                    barberRequestNew.agreeView.layoutIfNeeded()
                    barberRequestNew.agreeView.isHidden = false
                    barberRequestNew.chatBtn.addTarget(self, action: #selector(self.chat), for: .touchUpInside)
                    barberRequestNew.chatBtn.isHidden = false
                    barberRequestNew.declineBtn.isEnabled = true
                    barberRequestNew.completeBtn.addTarget(self, action: #selector(self.completeRequest(sender:)), for: .touchUpInside)
                    
                    barberRequestNew.cancelBtn.addTarget(self, action: #selector(self.cancelRequest(sender:)), for: .touchUpInside)
                    
                }
                
            }
            
        } else {
            barberRequestNew.stackAcceptDecline.isHidden = false
            if userType == 1 {
                barberRequestNew.statusLabel.isHidden = true
                if barberRequestsArray[indexPath.row]["customerChangeTime"] as? Bool == true  {
                    if barberRequestsArray[indexPath.row]["barberAnswered"] as? Bool == true  {
                        barberRequestNew.agreeBtn.isEnabled = true
                    }
                    barberRequestNew.questionView.isHidden = false
                    
                    barberRequestNew.declineBtn.isEnabled = true
                    
                }
                    
                else{
                    barberRequestNew.agreeBtn.isEnabled = false
                    barberRequestNew.declineBtn.isEnabled = true
                    barberRequestNew.statusLabel.text = "barber hasnt answered yet"
                    barberRequestNew.statusLabel.isHidden = false
                }
                
            }else{
                
                if barberRequestsArray[indexPath.row]["barberChangeTime"] as? Bool == true  {
                    if barberRequestsArray[indexPath.row]["customerAnswered"] as? Bool == true  {
                        barberRequestNew.statusLabel.text = ""
                        barberRequestNew.statusLabel.isHidden = false
                        
                        barberRequestNew.agreeBtn.isEnabled = true
                    }
                    barberRequestNew.questionView.isHidden = false
                    
                    barberRequestNew.declineBtn.isEnabled = true
                    
                }else{
                    barberRequestNew.agreeBtn.isEnabled = false
                    barberRequestNew.declineBtn.isEnabled = true
                    barberRequestNew.statusLabel.text = "customer hasnt answered yet"
                    barberRequestNew.statusLabel.isHidden = false
                }
            }
            if barberRequestsArray[indexPath.row]["canceled"] as? Bool == true {
                
                barberRequestNew.chatBtn.tag = indexPath.row
                
                barberRequestNew.questionView.isHidden = true
                barberRequestNew.barberCompleteRequest.isHidden = true
                print("\(barberRequestsArray[indexPath.row]["requestID"])")
                barberRequestNew.topseperateView.isHidden = true
                barberRequestNew.bottomSeperateView.isHidden = true
                barberRequestNew.stackAcceptDecline.isHidden = true
                
                barberRequestNew.containerView.backgroundColor = UIColor(hexString: "#ebebeb")
                
                barberRequestNew.agreeView.isHidden = false
                barberRequestNew.statusLabel.isHidden = true
                
            }
            
            
            barberRequestNew.agreeView.isHidden = true
        }
        barberRequestNew.firstQuestionBtn.tag = indexPath.row
        barberRequestNew.secondQuestionBtn.tag = indexPath.row
        barberRequestNew.thirdQuestionBtn.tag = indexPath.row
        
        barberRequestNew.agreeBtn.tag = indexPath.row
        barberRequestNew.declineBtn.tag = indexPath.row
        barberRequestNew.completeBtn.tag = indexPath.row
        
        barberRequestNew.firstQuestionBtn.ButtonborderRoundradius(radius: 10.0)
        barberRequestNew.secondQuestionBtn.ButtonborderRoundradius(radius: 10.0)
        barberRequestNew.thirdQuestionBtn.ButtonborderRoundradius(radius: 10.0)
        
        barberRequestNew.stackAcceptDecline.ViewborderRound(border: 1, corner: 8)
        
        barberRequestNew.chatBtn.ButtonborderRoundradius(radius: 10.0)
        barberRequestNew.completeBtn.ButtonborderRoundradius(radius: 10.0)
        barberRequestNew.cancelBtn.ButtonborderRoundradius(radius: 10.0)
        
        
        barberRequestNew.firstQuestionBtn.addTarget(self, action: #selector(self.BtnClick(sender:)), for: .touchUpInside)
        barberRequestNew.secondQuestionBtn.addTarget(self, action: #selector(self.BtnClick(sender:)), for: .touchUpInside)
        barberRequestNew.thirdQuestionBtn.addTarget(self, action: #selector(self.BtnClick(sender:)), for: .touchUpInside)
        
        barberRequestNew.agreeBtn.addTarget(self, action: #selector(self.agreeClick(sender:)), for: .touchUpInside)
        barberRequestNew.declineBtn.addTarget(self, action: #selector(self.declineClick(sender:)), for: .touchUpInside)
        
        
        
        
        
        return barberRequestNew
        }
    }
    
    
    
    func barberAnswered(){
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        //Request
        barberRequestsArray.removeAll()
        let nib = UINib.init(nibName: "BarberRequest", bundle: nil)
        self.barberRequectTableView.register(nib, forCellReuseIdentifier: "BarberRequest")
        //End
        
        //Review
        let nibCustomerReview = UINib.init(nibName: "customerReviewTableViewCell", bundle: nil)
        self.barberRequectTableView.register(nibCustomerReview, forCellReuseIdentifier: "customerReviewTableViewCell")
        let nibBarberView = UINib.init(nibName: "barberReviewTableViewCell", bundle: nil)
        self.barberRequectTableView.register(nibBarberView, forCellReuseIdentifier: "barberReviewTableViewCell")
        //End
        self.barberRequectTableView.separatorStyle = .none
        self.barberRequectTableView.backgroundView?.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
        if userType == 3{
            if let barbersNode = userData["barbersID"] as? [String:Any]  {
                shopBarberNode.removeAll()
                for (key,value) in barbersNode {
                    shopBarberNode.append(key)
                }
                selectedBarberRequest = shopBarberNode.first as? String ?? ""
                
                print(shopBarberNode)
                load_requests()
                
            }
            
            //
        }else{
            load_requests()
            
        }
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
    
}

//MARK :- Action Functions
extension barberRequestsViewController {
    @objc func chat(sender:UIButton){
        let showChat = self.storyboard?.instantiateViewController(withIdentifier: "parentChatView") as! parentChatViewController
        
        showChat.requestID = barberRequestsArray[sender.tag]["requestID"] as? String ?? ""
       
        self.navigationController?.pushViewController(showChat, animated: true)
    }
    
    // Mark - check to complete request from barber only .
    @objc func completeRequest(sender:UIButton){
        var userID = userData["userID"] as? String ?? ""
        var barberComment = "This Request has marked as completed. You are free to leave a review now"
        let requestID = barberRequestsArray[sender.tag]["requestID"]!
        let customerID = barberRequestsArray[sender.tag]["customerID"]!
        let barberID = barberRequestsArray[sender.tag]["barberID"]!
        
        value_update = [
            "barberComment":barberComment as AnyObject,"barberAnswered":true as AnyObject,"barberChangeTime":false as AnyObject,
            "customerComment":barberComment as AnyObject,"customerAnswered":true as AnyObject,"customerChangeTime":false as AnyObject,
            "complete":true as AnyObject
        ]
        print("value_update\(value_update)")
        
        ref.child("requests").child("barbers").child(barberID as! String).child(requestID as! String).updateChildValues(value_update)
        ref.child("requests").child("customers").child(customerID as! String).child(requestID as! String).updateChildValues(value_update)
        self.view.makeToast("Answer Submitted")
        load_requests()
    }
    @objc  func cancelRequest(sender:UIButton){
        var userID = userData["userID"] as? String ?? ""
        var barberComment = "Customer dont show up"
        let requestID = barberRequestsArray[sender.tag]["requestID"]!
        let customerID = barberRequestsArray[sender.tag]["customerID"]!
        let barberID = barberRequestsArray[sender.tag]["barberID"]!
        
        value_update = ["barberComment":barberComment as AnyObject,"barberAnswered":false as AnyObject,"barberChangeTime":false as AnyObject,
                        "customerComment":barberComment as AnyObject,"customerAnswered":false as AnyObject,"customerChangeTime":false as AnyObject,
                        "customerNotShow":true as AnyObject
        ]
        print("value_update\(value_update)")
        
        ref.child("requests").child("barbers").child(barberID as! String).child(requestID as! String).updateChildValues(value_update)
        ref.child("requests").child("customers").child(customerID as! String).child(requestID as! String).updateChildValues(value_update)
        self.view.makeToast("Answer Submitted")
        load_requests()
    }
   
    
    
    @objc func Review(sender:UIButton){
        let postReview = self.storyboard?.instantiateViewController(withIdentifier: "postReviewView") as? postReviewViewController
        postReview?.requestArray =  barberRequestsArray[sender.tag]
        
        self.navigationController?.pushViewController(postReview!, animated: true)
    }
    @objc func BtnClick(sender:UIButton){
        var userID = userData["userID"] as? String ?? ""
        var barberComment = sender.titleLabel?.text
        let requestID = barberRequestsArray[sender.tag]["requestID"]!
        let customerID = barberRequestsArray[sender.tag]["customerID"]!
        let barberID = barberRequestsArray[sender.tag]["barberID"]!
        
        if userType == 1 {
            value_update = ["barberComment": barberComment as AnyObject , "barberAnswered":false as AnyObject,"barberChangeTime":true as AnyObject,
                            "customerComment":barberComment as AnyObject,"customerAnswered":true as AnyObject,"customerChangeTime":false as AnyObject,
            ]
        }else{
            value_update = ["barberComment": barberComment  as AnyObject, "barberAnswered":true as AnyObject,"barberChangeTime":false as AnyObject,
                            "customerComment":barberComment as AnyObject,"customerAnswered":false as AnyObject,"customerChangeTime":true as AnyObject,
            ]
        }
        print("value_update\(value_update)")
        
        ref.child("requests").child("barbers").child(barberID as! String).child(requestID as! String).updateChildValues(value_update)
        ref.child("requests").child("customers").child(customerID as! String).child(requestID as! String).updateChildValues(value_update)
        self.view.makeToast("Answer Submitted")
        load_requests()
        
        //ref.updateChildValues(childUpdates)
    }
    @objc  func agreeClick(sender:UIButton){
        var userID = userData["userID"] as? String ?? ""
        var barberComment = "Agreed. Meet you there"
        let requestID = barberRequestsArray[sender.tag]["requestID"]!
        let customerID = barberRequestsArray[sender.tag]["customerID"]!
        let barberID = barberRequestsArray[sender.tag]["barberID"]!
        
        
        value_update = ["barberComment":barberComment as AnyObject,"barberAnswered":true as AnyObject,"barberChangeTime":false as AnyObject,
                        "customerComment":barberComment as AnyObject,"customerAnswered":true as AnyObject,"customerChangeTime":false as AnyObject,
                        "agree":true as AnyObject
        ]
        print("value_update\(value_update)")
        
        ref.child("requests").child("barbers").child(barberID as! String).child(requestID as! String).updateChildValues(value_update)
        ref.child("requests").child("customers").child(customerID as! String).child(requestID as! String).updateChildValues(value_update)
        self.view.makeToast("Answer Submitted")
        load_requests()
    }
    @objc func declineClick(sender:UIButton) {
        let userID = userData["userID"] as? String ?? ""
        let barberComment = "This Request has been canceled!"
        let customerComment = "Sorry!, I had to cancel this request"
        let requestID = barberRequestsArray[sender.tag]["requestID"]!
        let customerID = barberRequestsArray[sender.tag]["customerID"]!
        let barberID = barberRequestsArray[sender.tag]["barberID"]!
        
        if userType == 1 {
            value_update = [
                "barberComment":barberComment as AnyObject ,"barberAnswered":true as AnyObject, "barberChangeTime": false as AnyObject,
                "canceled":true as AnyObject,"customerComment":customerComment as AnyObject , "customerAnswered":true as AnyObject, "customerChangeTime":false as AnyObject,
            ]
        }else{
            value_update = ["barberComment":customerComment as AnyObject,"barberAnswered": true as AnyObject,"barberChangeTime":false as AnyObject,"canceled": true as AnyObject ,
                            "customerComment":barberComment as AnyObject,"customerAnswered":true as AnyObject , "customerChangeTime":false as AnyObject,
            ]
        }
        
        print("value_update\(value_update)")
        
        ref.child("requests").child("barbers").child(barberID as! String).child(requestID as! String).updateChildValues(value_update)
        ref.child("requests").child("customers").child(customerID as! String).child(requestID as! String).updateChildValues(value_update)
        self.view.makeToast("Answer Submitted")
        load_requests()
    }
}
//Load Request 
extension barberRequestsViewController {
    func load_requests(){
        status = "requests"

        self.barberRequestsArray.removeAll()
        print(node)
        var node_id = userData["userID"] as? String ?? ""
        if userType == 3 {
            print(selectedBarberRequest)
            if selectedBarberIndex != 0 {
                if  selectedBarberIndex + 1 == shopBarberNode.count {
                    selectedBarberRequest = shopBarberNode[selectedBarberIndex]
                    node_id = selectedBarberRequest
                    
                }
                else{
                    self.barberRequectTableView.reloadData()
                    
                    return
                }
            }
            if selectedBarberRequest == "" {
                
                return
            }
            node_id = selectedBarberRequest
        }
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        self.ref.child("requests").child(node).child(node_id).observe(.childAdded, with: {(snapshot) in
            
            // MARK - Check to get request for customer or Barber
            
            if let checkRequest = snapshot.value as? [String:AnyObject]{
                
                if userType == 1 {
                    self.barberRequestsArray.append(checkRequest)
                }else {
                    if self.requestCompleted == false {
                        if let agree = checkRequest["complete"] as? Bool  {
                            if agree == false {
                                self.barberRequestsArray.append(checkRequest)
                            }
                        }else{
                            self.barberRequestsArray.append(checkRequest)
                        }
                    }else{
                        if let agree = checkRequest["complete"] as? Bool  {
                            if agree == true {
                                self.barberRequestsArray.append(checkRequest)
                            }
                        }
                    }
                }
                
                
                MBProgressHUD.hide(for: self.view, animated: true)
                self.barberRequectTableView.reloadData()
                
                
            }else{
                print("snapshot.value\(snapshot.value)")
            }
        })
        { (err) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast("there is no new request")
        }
        MBProgressHUD.hide(for: self.view, animated: true)
        
    }
    func loadCustomerRequest(){
        
    }
}
//End

//Load Reviews Api
extension barberRequestsViewController{
    func load_reviews(){
        self.reviewList.removeAll()
        status = "review"
        MBProgressHUD.showAdded(to: self.view, animated: true)
        var selected_node = "customers"
        var child = "toYou"
        var node_id = userData["userID"] as? String ?? ""
        if userType == 3 {
            if selectedBarberIndex != 0 {
                if  selectedBarberIndex + 1 == shopBarberNode.count {
                    selectedBarberRequest = shopBarberNode[selectedBarberIndex]
                    node_id = selectedBarberRequest
                }
                else{
                    self.barberRequectTableView.reloadData()
                    
                    return
                }
            }
            if selectedBarberRequest == "" {
                
                return
            }
            node_id = selectedBarberRequest
        }
        load_review_action(selected_node: node, child: "toYou", node_id: node_id)
        load_review_action(selected_node: node, child: "toOther", node_id: node_id)
        
        
        
    }
    func load_review_action(selected_node:String,child:String,node_id:String){
        self.ref.child("reviews").child(selected_node).child(node_id).child(child).observe(.value, with: {(snapshot) in
            MBProgressHUD.hide(for: self.view, animated: true)
            
            if let checkRequest = snapshot.value as? [String:Any]{
                for (key,value) in checkRequest {
                    self.reviewList.append(value as! [String : AnyObject])
                }
                self.barberRequectTableView.reloadData()
            }else{
                self.view.makeToast("there is no new review")
                print("snapshot.value\(snapshot.value)")
            }
        })
        { (err) in
            MBProgressHUD.hide(for: self.view, animated: true)
            self.view.makeToast("there is no new review")
        }
    }
}

