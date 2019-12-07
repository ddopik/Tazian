//
//  userViewController.swift
//  barber
//
//  Created by amr sobhy on 3/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class userViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var preferenceScrollView: UIScrollView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    @IBOutlet weak var thirdOffer: UIImageView!
    @IBOutlet weak var secondOffer: UIImageView!
    @IBOutlet weak var firstOffer: UIImageView!
    @IBOutlet weak var barberView: UIView!
    @IBOutlet weak var guideBtn: UIButton!
    var pref = ["Show Barbers Randomly Sorting","Sort Barbers Ascending By Rating From high to low",
                "Sort Barbers Ascending by Price from high to low","Sort Barbers Ascending by Distance from near to far"]
    var images = ["heart","heart","price","ic_marker_red"]
     var sub = ["","stars","up to ","up to "]
    var rating = [[],[" 4- 5 "," 3 - 5 ","0 - 5"],["$","$$","$$$"],["10 KM","20 KM","30 KM"]]
    var loaded = false
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = userData["username"] as? String ?? ""
         self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
        
        preferenceScrollView.isPagingEnabled = true
        preferenceScrollView.showsHorizontalScrollIndicator = true
        containerView.ViewborderRound(border: 0.3, corner: 15)
        for view in self.preferenceScrollView.subviews {
            view.removeFromSuperview()
        }
        loadBarberView()
        guideBtn.ButtonborderRound()
        
    }
    @IBOutlet var userImg: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
        userImg.ImageBorderCircle()
        self.navigationController?.navigationBar.backgroundColor = UIColor(hexString:navigationColorCode)
        if userType == 1 {
            preferenceScrollView.isHidden = false
            barberView.isHidden = true
        }else{
            
            preferenceScrollView.isHidden = true
            barberView.isHidden = false
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    func loadBarberView(){
            preferenceScrollView.contentSize = CGSize(width: (self.view.bounds.size.width ) * CGFloat(pref.count),height: 130)
            for (index,main) in pref.enumerated() {
                if let preferenceViewnew = Bundle.main.loadNibNamed("preference", owner: self, options: nil)?.first as? preferenceView {
                    preferenceViewnew.mainLabel.text = main
                    if index == selected_switch {
                        preferenceViewnew.switchBtn.isOn = true
                        preferenceViewnew.segment.isEnabled = true
                    }else{
                        preferenceViewnew.switchBtn.isOn = false
                        preferenceViewnew.segment.isEnabled = false
                    }
                    if index != 0 {
                        preferenceViewnew.segment.isHidden = false
                        preferenceViewnew.segment.setTitle(rating[index][0], forSegmentAt: 0)
                        preferenceViewnew.segment.setTitle(rating[index][1], forSegmentAt: 1)
                        preferenceViewnew.segment.insertSegment(withTitle: rating[index][2], at: 2, animated: true)
                        
                    }else{
                        preferenceViewnew.segment.isHidden = true
                    }
                    
                    preferenceViewnew.switchBtn.addTarget(self, action: #selector(self.changeSelection(sender:)), for: .valueChanged)
                    preferenceViewnew.image.image = UIImage(named:images[index])
                    preferenceViewnew.subLabel.text = sub[index]
                    preferenceViewnew.switchBtn.tag = index
                     preferenceScrollView.addSubview(preferenceViewnew)
                    preferenceViewnew.frame.size.width = self.view.bounds.size.width
                    preferenceViewnew.frame.size.height = 130
                    preferenceViewnew.frame.origin.x = (self.view.bounds.size.width ) * CGFloat(index)
                    
                    
                   
                }
            }
        
           
        
        if loaded == false {
            for view in self.preferenceScrollView.subviews {
                view.removeFromSuperview()
            }
            loaded = true
            loadBarberView()
        }
       
       
    }
    @objc func changeSelection(sender:UISwitch){
        selected_switch = sender.tag
      //  preferenceScrollView.removeFromSuperview()
        for view in self.preferenceScrollView.subviews {
            view.removeFromSuperview()
        }
        loadBarberView()
        
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
