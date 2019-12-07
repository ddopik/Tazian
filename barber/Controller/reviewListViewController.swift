//
//  reviewListViewController.swift
//  barber
//
//  Created by amr sobhy on 4/22/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import Firebase
import Toast
import MBProgressHUD

class reviewListViewController: UIViewController , UITableViewDelegate , UITableViewDataSource ,FloatRatingViewDelegate{
    
    var reviewList = [Dictionary<String,AnyObject>]()
    var reviewType = 0
    var selectedBarberRequest = ""
    var selectedBarberIndex = 0
    @IBOutlet weak var tableTopConstraint: NSLayoutConstraint!
    var ref: DatabaseReference!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  reviewList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userType == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customerReviewTableViewCell") as? customerReviewTableViewCell
             cell?.parent = self
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

                cell.parent = self
                cell.totalReview.delegate = self
                cell.priceReview.delegate = self
                cell.serviceReview.delegate = self
                cell.waitingReview.delegate = self
                return cell
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "customerReviewCell") as! customerReviewTableViewCell
                cell.reviewList = reviewList[indexPath.row]

                cell.parent = self
                cell.totalReview.delegate = self
                cell.arrivalReview.delegate = self
                cell.behaviourReview.delegate = self
                
                return cell
            }
            
           
            
        }
    }
    
    

    @IBOutlet weak var reviewTable: UITableView!
    @IBOutlet weak var changeSelect: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        self.changeSelect.isHidden = true
        self.tableTopConstraint.constant = 0
        
        let nib = UINib.init(nibName: "customerReviewTableViewCell", bundle: nil)
        self.reviewTable.register(nib, forCellReuseIdentifier: "customerReviewTableViewCell")
        let nib2 = UINib.init(nibName: "barberReviewTableViewCell", bundle: nil)
        self.reviewTable.register(nib2, forCellReuseIdentifier: "barberReviewTableViewCell")
        self.reviewTable.separatorStyle = .none
        self.reviewTable.backgroundView?.backgroundColor = UIColor.clear
        self.reviewTable.allowsSelection = false
        if userType == 3{
            if let barbersNode = userData["barbersID"] as? [String:Any]  {
                shopBarberNode.removeAll()
                for (key,value) in barbersNode {
                    shopBarberNode.append(key)
                }
                selectedBarberRequest = shopBarberNode.first as? String ?? ""
                
                print(shopBarberNode)
                
            }
            
            //
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func changeAction(_ sender: Any) {
    }
    

}
extension reviewListViewController{
    func load_reviews(){
        self.reviewList.removeAll()
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
                    self.reviewTable.reloadData()
                    
                    return
                }
            }
            if selectedBarberRequest == "" {
                
                return
            }
            node_id = selectedBarberRequest
        }
        //self.ref.child("reviews").child("customers").child(requestArray["barberID"] as? String ?? "").child("toYou").child(reviewID).setValue(barberToCustomer)
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
                self.reviewTable.reloadData()
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
