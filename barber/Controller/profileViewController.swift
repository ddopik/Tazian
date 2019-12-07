//
//  profileViewController.swift
//  barber
//
//  Created by amr sobhy on 3/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import Firebase
import Toast
import MBProgressHUD
import Alamofire
import AlamofireImage
class profileViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource ,FloatRatingViewDelegate , UITextFieldDelegate{
    
    
    //MARK: - top container declaration :
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet var firstRateLabel: UILabel!
    
    @IBOutlet weak var secondView: UIView!
    
    @IBOutlet var secondRateLabel: UILabel!
    
    @IBOutlet weak var thirdView: UIView!
    
    @IBOutlet var thirdRateLabel: UILabel!
    
    @IBOutlet weak var firstRate: FloatRatingView!
    
    @IBOutlet weak var secondRate: FloatRatingView!
    
    @IBOutlet weak var thirdRate: FloatRatingView!
    var rate1 = "1"
    var rate2 = "2"
    var rate3 = "3"
    @IBOutlet weak var allRate: FloatRatingView!
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
    
    @IBAction func changeAction(_ sender: UISegmentedControl) {
        
        //changeBtn.removeBorder(color: UIColor.clear.cgColor)
        if sender.selectedSegmentIndex == 0 {
            mainTableView.isHidden = true
            dataView.isHidden = false
        }else {
            mainTableView.isHidden = false
            dataView.isHidden = true
            selectedCell = sender.selectedSegmentIndex
            mainTableView.reloadData()
        }
        sender.changeUnderlinePosition()
    }
    @IBOutlet var changeBtn: UISegmentedControl!
    // tableview section start
    @IBOutlet weak var mainTableView: UITableView!
    //end
    
    // MARK: - data Section Declaration
    
    @IBOutlet weak var updateBtn: UIButton!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var fullnameText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet var dataView: UIView!
    
    @IBOutlet var emailText: UITextField!
    @IBAction func updateAction(_ sender: Any) {
        
        let userID = userData["userID"] as? String ?? ""
        let value_update = ["email":emailText.text as AnyObject,
                            "fullname":fullnameText.text as AnyObject,"username":usernameText.text as AnyObject,
                            ]
        var node = ""
        if userType == 1 {
            node = "customers"
        }
        else if userType == 2 {
            node = "barbers"
        }
        else if userType == 3 {
            node = "shops"
        }
        userData["fullname"] = fullnameText.text as AnyObject
        userData["username"] = usernameText.text as AnyObject
        userData["email"] = emailText.text as AnyObject
        self.ref.child("users").child(node).child(userID as? String ?? "" ).updateChildValues(value_update)
        self.view.makeToast("Updated")
    }
    
    //End data declaration
    
    
    
    var value_update :[String:AnyObject]!
    var data_user = [userData["username"] as? String ?? "",userData["fullname"] as? String ?? "",userData["phone"] as? String ?? "",userData["city"] as? String ?? "",userData["address"] as? String ?? ""]
    var ref:DatabaseReference!
    var databaseHandler: DatabaseHandle!
    var selectedCell = 0
    
    
    var favouriteArray = [Dictionary<String,AnyObject>]()
    var favouriteKey = [String]()
    
    var reviewList = [Dictionary<String,AnyObject>]()
    
    //tableview section end
    
    var profileData = userData
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = userData["userID"] as? String ?? ""
        // Do any additional setup after loading the view.
        ref = Database.database().reference()
        self.navigationController?.navigationBar.isHidden = false
        self.load_reviews()
        self.load_favourites()
        let nib = UINib.init(nibName: "customerReviewTableViewCell", bundle: nil)
        self.mainTableView.register(nib, forCellReuseIdentifier: "customerReviewTableViewCell")
        let nib2 = UINib.init(nibName: "barberReviewTableViewCell", bundle: nil)
        self.mainTableView.register(nib2, forCellReuseIdentifier: "barberReviewTableViewCell")
        self.mainTableView.separatorStyle = .none
        self.mainTableView.backgroundView?.backgroundColor = UIColor.clear
        self.mainTableView.allowsSelection = false
        
        //top container data
        
        nameLabel.text = profileData["fullname"] as? String ?? "name"
        //emailLabel.text = profileData["email"] as? String ?? "email"
        
        firstView.ViewborderRound(border: 0.4, corner: 10)
        secondView.ViewborderRound(border: 0.4, corner: 10)
        thirdView.ViewborderRound(border: 0.4, corner: 10)
        
        
        if let imageURL = URL(string: profileData["imageURL"] as? String ?? "") as? URL {
            userImg.af_setImage(withURL: imageURL, placeholderImage: UIImage(named: "logo"))
        }
        // Initialization code
        
        firstRate.delegate = self
        secondRate.delegate = self
        thirdRate.delegate = self
        allRate.delegate = self
        firstRate.setupFloatEdit(index:0)
        secondRate.setupFloatEdit(index:1)
        thirdRate.setupFloatEdit(index:2)
        allRate.setupFloatEdit(index: 4)
        if userType == 1 {
            firstRateLabel.text = "OverAll Rate"
            secondRateLabel.text = "Attendance Rate"
            thirdRateLabel.text = "Behaviour Rate"
            
            firstRate.rating = profileData["overallRating"] as? Double ?? 0.0
            secondRate.rating = profileData["attendance"] as? Double ?? 0.0
            thirdRate.rating = profileData["behavior"] as? Double ?? 0.0
        }
        else if userType == 2 {
            firstRateLabel.text = "Price Rate"
            secondRateLabel.text = "Waiting Rate"
            thirdRateLabel.text = "Service Rate"
            
            firstRate.rating = profileData["price"] as? Double ?? 0.0
            secondRate.rating = profileData["waiting"] as? Double ?? 0.0
            thirdRate.rating = profileData["service"] as? Double ?? 0.0
        }
        
        changeBtn.addUnderlineForSelectedSegment()
        changeBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        changeBtn.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        
        
        //data Text Start
        usernameText.text = profileData["username"] as? String ?? ""
        fullnameText.text = profileData["fullname"] as? String ?? ""
        phoneText.text = profileData["mobile"] as? String ?? ""
        emailText.text = profileData["email"] as? String ?? ""
        updateBtn.ButtonborderRoundradius(radius: 10)
        //data Text End
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedCell == 2 {
            return favouriteArray.count
        }else{
            return reviewList.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedCell == 2 {
            return 80
        }else{
            return 190
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedCell == 2 {
            //profileTopCell
            let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! FavouriteTableViewCell
            cell.barberName.text = favouriteArray[indexPath.row]["username"] as! String
            cell.shopName.text = favouriteArray[indexPath.row]["shopname"] as! String
            cell.deleteBtn.tag = indexPath.row
            cell.deleteBtn.addTarget(self, action: #selector(self.deleteBarber), for: .touchUpInside)
            cell.containerView.ViewborderRound(border: 0.5, corner: 10.0)
            return cell
        } else {
            if userType == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "customerReviewTableViewCell") as? customerReviewTableViewCell
                cell?.reviewList = reviewList[indexPath.row]
                cell?.selectionStyle = .none
                cell?.totalReview.delegate = self
                cell?.arrivalReview.delegate = self
                cell?.behaviourReview.delegate = self
                return cell!
            }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "barberReviewTableViewCell") as! barberReviewTableViewCell
                cell.selectionStyle = .none
                cell.reviewList = reviewList[indexPath.row]
                cell.totalReview.delegate = self
                cell.priceReview.delegate = self
                cell.serviceReview.delegate = self
                cell.waitingReview.delegate = self
                return cell
                
            }
        }
    }
    @objc func deleteBarber (sender: UIButton){
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateBtn.isHidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateProfile(sender:UIButton){
        
        self.view.makeToast("Answer Submitted")
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

// MARK: - Outlet declaration


// MARK: - network calling and handling
extension  profileViewController {
    func load_favourites(){
        self.favouriteArray.removeAll()
        self.favouriteKey.removeAll()
        if userType == 1 {
            node = "customers"
        }else{
            node = "barbers"
            
        }
        databaseHandler = self.ref.child("users").child(node).child(userData["userID"] as? String ?? "").child("favorites").observe(.value, with: {(snapshot) in
            print(snapshot.value)
            
            // Mark - Check to get request for customer or Barber
            
            if let checkRequest = snapshot.value as? [String:AnyObject]{
                
                for key in checkRequest.keys{
                    
                    self.ref.child("users").child("barbers").child(key).observe(.value, with: {(snapshot) in
                        
                        print(snapshot.value)
                        // Mark - Check to get request for customer or Barber
                        
                        if let checkRequest = snapshot.value as? [String:AnyObject]{
                            self.favouriteArray.append(checkRequest)
                            self.mainTableView.reloadData()
                        }
                        print(self.favouriteArray)
                    })
                    { (err) in
                        
                    }
                }
                
            }
            
            
        })
        { (err) in
            
            
        }
        
    }
    func load_reviews(){
        self.reviewList.removeAll()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        var selected_node = "customers"
        var child = "toYou"
        //self.ref.child("reviews").child("customers").child(requestArray["barberID"] as? String ?? "").child("toYou").child(reviewID).setValue(barberToCustomer)
        if userType == 2 {
            
            selected_node = "barbers"
           
            self.ref.child("reviews").child(selected_node).child(userData["userID"] as? String ?? "").child(child).observe(.value, with: {(snapshot) in
                MBProgressHUD.hide(for: self.view, animated: true)
                
                if let checkRequest = snapshot.value as? [String:Any]{
                    print(checkRequest)
                    for (key,value) in checkRequest {
                        print(value)
                        
                        self.reviewList.append(value as! [String : AnyObject])
                    }
                    self.mainTableView.reloadData()
                }else{
                    print("snapshot.value\(snapshot.value)")
                }
            })
            { (err) in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.makeToast("there is no new review")
            }
        }else{
            
            self.ref.child("reviews").child("customers").child(userData["userID"] as? String ?? "").child("toYou").observe(.value, with: {(snapshot) in
                
                if let checkRequest = snapshot.value as? [String:AnyObject]{
                    print(checkRequest)
                    
                    self.reviewList.append(checkRequest)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.mainTableView.reloadData()
                }else{
                    print("snapshot.value\(snapshot.value)")
                }
            })
            { (err) in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.makeToast("there is no new review")
            }
            
            self.ref.child("reviews").child("customers").child(userData["userID"] as? String ?? "").child("toOther").observe(.childAdded, with: {(snapshot) in
                
                if let checkRequest = snapshot.value as? [String:AnyObject]{
                    self.reviewList.append(checkRequest)
                    print(self.reviewList)
                    
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.mainTableView.reloadData()
                }else{
                    print("snapshot.value\(snapshot.value)")
                }
            })
            { (err) in
                MBProgressHUD.hide(for: self.view, animated: true)
                self.view.makeToast("there is no new review")
            }
        }
        
    }
}

