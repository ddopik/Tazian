//
//  FirstViewController.swift
//  barber
//
//  Created by amr sobhy on 3/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabaseUI
import MBProgressHUD
import Toast
import CoreLocation
import UICircularProgressRing
import SDWebImage
import AlamofireImage
class FirstViewController: UIViewController  ,CLLocationManagerDelegate {

    @IBOutlet weak var barberScrollView: UIScrollView!
    @IBOutlet weak var discountScrollView: UIScrollView!
    
    @IBOutlet weak var barberTypeSegment: UISegmentedControl!
    var barbers = [Dictionary<String,AnyObject>]()
    var offers = [Dictionary<String,AnyObject>]()
    var barberType = "barbers"
    var ref : DatabaseReference!
    var databaseHandler: DatabaseHandle!
    let locationManager = CLLocationManager()
    var myLongtide = 0.0
    var myLatitude = 0.0
    override func viewDidLoad() {
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        global_check_location(controler: self)
        myLongtide =  myLocation.longtide
        myLatitude =  myLocation.latitude

        ref = Database.database().reference()
        super.viewDidLoad()
        if userType == 1 {
            barberScrollView.contentSize = CGSize(width: self.view.bounds.size.width * CGFloat(barbers.count),height: self.view.bounds.size.height)
            
            barberScrollView.isPagingEnabled = true
            barberScrollView.showsHorizontalScrollIndicator = false
            discountScrollView.contentSize = CGSize(width: self.view.bounds.size.width * CGFloat(offers.count),height: 160)
            
            discountScrollView.isPagingEnabled = true
            discountScrollView.showsHorizontalScrollIndicator = false

            loadBarberRandom()
            loadBarberView()
            
           // loadOfferView()
           loadOffers()
        }
        else if userType == 2 {
            barberScrollView.isHidden = true
            
        }
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }

    @IBAction func barberTypeAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            barberType = "barbers"
        }else{
            barberType = "shops"
        }
        loadBarberRandom()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadBarberView(){
        print(barbers.count)
         barberScrollView.contentSize = CGSize(width: self.view.bounds.size.width * CGFloat(barbers.count),height: self.barberScrollView.bounds.size.height)
        barberScrollView.backgroundColor = UIColor(hexString:"#ebebeb")
        for (index,barber) in barbers.enumerated() {
            if let barberViewnew = Bundle.main.loadNibNamed("Barber", owner: self, options: nil)?.first as? barberView {
                let myLocation = CLLocation(latitude:barber["latitude"] as? Double ??  0.0 , longitude: barber["longitude"] as? Double ??  0.0)
                let coordinate₁ = CLLocation(latitude: 5.0, longitude: 3.0)
                let distanceValue = calculateDistanceInMiles(from: myLocation, to: coordinate₁)
                
              barberViewnew.imgViewWidthConstraint.constant = barberViewnew.imgView.bounds.size.height
                barberViewnew.imgView.frame.size.width = barberViewnew.imgView.bounds.size.height
                print(barberViewnew.imgView.bounds.size.width)
                 print(barberViewnew.imgView.bounds.size.height)
                if let imageURL = URL(string: barber["imageURL"] as? String ?? "") as? URL {   
                        barberViewnew.imgView.af_setImage(withURL: imageURL, placeholderImage: UIImage(named: "logo"))
                }
                barberViewnew.imgView.ImageBorderCircle()
                
              
               
                
                
                barberViewnew.distanceLabel.text = distanceValue
                
                if barberType == "shops"{
                    barberViewnew.nameLabel.text = barber["title"] as? String ?? ""
                    barberViewnew.usernameLabel.text = barber["personInCharge"] as? String ?? ""
                    
                }else{
                    barberViewnew.nameLabel.text = barber["username"] as? String ?? ""
                    barberViewnew.usernameLabel.text = barber["shopname"] as? String ?? ""
                    
                }
                barberViewnew.addressLabel.text = barber["city"] as? String ?? ""
                print("timeconvert\(convertTimestamp(serverTimestamp: barber["membersince"] as! Double))")
                barberViewnew.nextBtn.tag = index
                barberViewnew.prevBtn.tag = index
                barberViewnew.nextBtn.addTarget(self, action: #selector(self.nextAction(sender:)), for: .touchUpInside)
                if index > 0 {
                     barberViewnew.prevBtn.addTarget(self, action: #selector(self.prevAction(sender:)), for: .touchUpInside)
                }
                barberViewnew.heartBtn.tag = index
                barberViewnew.heartBtn.addTarget(self, action: #selector(self.sendRequest(sender:)), for: .touchUpInside)
                
                barberViewnew.favouriteBtn.tag = index
                barberViewnew.favouriteBtn.addTarget(self, action: #selector(self.add_to_favourite(sender:)), for: .touchUpInside)
                
                barberScrollView.addSubview(barberViewnew)
                barberViewnew.frame.size.width = self.view.bounds.size.width
                 barberViewnew.frame.size.height = self.barberScrollView.bounds.size.height
                barberViewnew.frame.origin.x = self.view.bounds.size.width * CGFloat(index)
               // let heightdownAction = ((barberViewnew.downActionBtnStack.bounds.size.width - 10.0 ) / 5.0 ) - 20.0
              //  print(heightdownAction)
                print((barberViewnew.downActionBtnStack.bounds.size.width - 10.0 ))
                print((barberViewnew.downActionBtnStack.bounds.size.height))
                //barberViewnew.downActionBtnHeight.constant = heightdownAction
                print((barberViewnew.downActionBtnStack.bounds.size.height))
                barberViewnew.priceView.value = CGFloat(barber["price"] as? Double ?? 0.0)
                barberViewnew.waitingView.value = CGFloat(barber["waiting"] as? Double ?? 0.0)
                barberViewnew.rateView.value = CGFloat(barber["service"] as? Double ?? 0.0)
              
               /*
                barberViewnew.nextBtn.ButtonborderRoundradius(radius: 10)
                barberViewnew.prevBtn.ButtonborderRoundradius(radius: 10)
                barberViewnew.heartBtn.ButtonborderRoundradius(radius: 10)
                barberViewnew.favouriteBtn.ButtonborderRoundradius(radius: 10)
                barberViewnew.locationBtn.ButtonborderRoundradius(radius: 10)
                */
                barberViewnew.nextBtn.ButtonborderRoundradius(radius: 10)
                barberViewnew.prevBtn.ButtonborderRoundradius(radius: 10)
                barberViewnew.heartBtn.ButtonborderRoundradius(radius: 10)
                barberViewnew.favouriteBtn.ButtonborderRoundradius(radius: 10)
                barberViewnew.locationBtn.ButtonborderRoundradius(radius: 10)
                
                 
            }
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    func loadOfferView(){
        discountScrollView.contentSize = CGSize(width: self.view.bounds.size.width * CGFloat(offers.count),height: 160)
         discountScrollView.backgroundColor = UIColor(hexString:"#ebebeb")
        for (index,offer) in offers.enumerated() {
            if let offerViewNew = Bundle.main.loadNibNamed("Offer", owner: self, options: nil)?.first as? offerView {
                let myLocation = CLLocation(latitude:offer["latitude"] as? Double ??  0.0 , longitude: offer["longitude"] as? Double ??  0.0)
                let coordinate₁ = CLLocation(latitude: 5.0, longitude: 3.0)
                let distanceValue = calculateDistanceInMiles(from: myLocation, to: coordinate₁)
                offerViewNew.containerView.ViewborderRound(border: 0.3,  corner: 20.0)
                offerViewNew.containerView.layer.borderColor = UIColor.red.cgColor
                offerViewNew.containerView.backgroundColor = UIColor(hexString:"#ebebeb")
                offerViewNew.name.text = offer["shopName"] as? String ?? ""
                offerViewNew.username.text = offer["barberName"] as? String ?? ""
                offerViewNew.distance.text = distanceValue
                offerViewNew.date.text = convertTimestamp(serverTimestamp: offer["timeorder"] as! Double)
                discountScrollView.addSubview(offerViewNew)
                offerViewNew.frame.size.width = self.view.bounds.size.width
                offerViewNew.frame.size.height = 160
                offerViewNew.frame.origin.x = self.view.bounds.size.width * CGFloat(index)
            }
        }
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    //func to load barbers random from firebase
    func loadBarberRandom(){
          MBProgressHUD.showAdded(to: self.view, animated: true)
        self.barbers.removeAll()
        for view in self.barberScrollView.subviews {
            view.removeFromSuperview()
        }
        
        let databaseHandler = ref.child("users").child(barberType).observe(.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.barbers.append(postDict)
           
            print(self.barbers)
            
             self.loadBarberView()
            
        })
        
    }
    func loadOffers(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        let databaseHandler = ref.child("advertising").observe(.childAdded, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            self.offers.append(postDict)
            
            print(self.offers)
            
         // self.loadOfferView()
        })
        print(self.offers.count)
        
        
    }
    
    @objc func nextAction(sender:UIButton){
        
        var slideToX = self.view.bounds.size.width * CGFloat(sender.tag + 1)
        barberScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:self.view.bounds.size.width, height:self.barberScrollView.frame.height), animated: true)

    }
    @objc func prevAction(sender:UIButton){
       
        var slideToX = self.view.bounds.size.width * CGFloat(sender.tag - 1)
        barberScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:self.view.bounds.size.width, height:self.barberScrollView.frame.height), animated: true)
      
    }
    
    @objc func sendRequest(sender:UIButton) {
       
        
        var userID = userData["userID"] as? String ?? ""
        var customerComment = "Could I come after 30 min from now?"
        var barberComment = "Could I come after 30 min from now?"
       

        
        let requestID = self.ref.child("requests").child("customers").child(userID).childByAutoId().key
        
        print(self.barbers[sender.tag])
        
        
        var newRequest = Requests.init(requestID: "\(requestID)", customerID: userID , customerName: userData["username"] as? String ?? "", customerToken: userData["token"] as? String ?? "", customerImageURL: userData["imageURL"] as? String ?? "", barberID: self.barbers[sender.tag]["userID"] as! String, barberName: self.barbers[sender.tag]["fullname"] as! String, barberToken: self.barbers[sender.tag]["token"] as! String, barberImageURL: self.barbers[sender.tag]["userID"] as! String, barberShopName: self.barbers[sender.tag]["shopname"] as! String, requestTime: [".sv": "timestamp"] as AnyObject, timeorder: [".sv": "timestamp"] as AnyObject, customerComment: customerComment, barberComment: barberComment, customerAnswered: true, barberAnswered: false, complete: false, customerReviewed: false, barberReviewed: false, canceled: false, customerChangeTime: false, barberChangeTime: true, offer: false, agree: false, barberNotShow: false, customerNotShow: false, discountValue: 0)
        var newUser = newRequest?.getData()
       
       print(newRequest)
        
        let childUpdates = ["/requests/barbers/\(self.barbers[sender.tag]["userID"] as! String)/\(requestID)": newUser,
                            "/requests/customers/\(userID)/\(requestID)/": newUser]
        ref.updateChildValues(childUpdates)
        self.view.makeToast("Requested sended successfully")
    }
    @objc public func add_to_favourite(sender: UIButton){
         var userID = userData["userID"] as? String ?? ""
        print(userID)
       // let childUpdates = [  "/users/customers/\(userID)/favorites/":
self.ref.child("users").child("customers").child(userID).child("favorites").setValue([self.barbers[sender.tag]["userID"] as! String:true])

//        ref.updateChildValues(childUpdates)
          self.view.makeToast("Added successfully")
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
