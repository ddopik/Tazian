//
//  masterHomeViewController.swift
//  barber
//
//  Created by amr sobhy on 3/25/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class masterHomeViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    
    @IBOutlet var paddingBottomConstraint: NSLayoutConstraint!
    @IBOutlet var mainStackHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        userBtn.ButtonborderRoundradius(radius: 8)
        homeBtn.ButtonborderRoundradius(radius: 8)
        feedbackBtn.ButtonborderRoundradius(radius: 8)
        
        super.viewDidLoad()
        updateView(selectedView:1)
        if userType == 1 {
            userLabel.text = "Account"
            homeLabel.text = "Home"
            feedbackLabel.text = "Requests"
            masterContainerController.screenType = 1
            masterContainerController.setupsegmentedControlCustomer()
            masterContainerController.updateViewCustomer()
        }else{
            userLabel.text = "Account"
            homeLabel.text = "Requests"
            feedbackLabel.text = "Reviews"
        }
        if userType == 3{
            if let barbersNode = userData["barbersID"] as? [String:Any]  {
                shopBarberNode.removeAll()
                for (key,value) in barbersNode {
                    shopBarberNode.append(key)
                }
                print(shopBarberNode)
                
            }
            
           //
        }
        // self.navigationController?.navigationBar.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var userBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var feedbackBtn: UIButton!
    
    @IBOutlet var homeLabel: UILabel!
    @IBOutlet var userLabel: UILabel!
    @IBOutlet var feedbackLabel: UILabel!
    
    lazy var masterContainerController : MasterContainerViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "masterContainer") as! MasterContainerViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    lazy var userViewController : userViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "userViewController") as! userViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    lazy var thirdViewController : thirdViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "thirdViewController") as! thirdViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    lazy var reviewListViewController : reviewListViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "reviewListView") as! reviewListViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func userAction(_ sender: Any) {
        updateView(selectedView:0)
         userViewController.view.isHidden = false
          masterContainerController.view.isHidden = true
        reviewListViewController.view.isHidden  = true
    }
    
    @IBAction func homeAction(_ sender: Any) {
        updateView(selectedView:1)
        if userType == 1 {
             masterContainerController.screenType = 1
             masterContainerController.setupsegmentedControlCustomer()
            masterContainerController.updateViewCustomer()
        }else{
            masterContainerController.barberRequestViewController.load_requests()
        }
       
         masterContainerController.view.isHidden = false
         userViewController.view.isHidden = true
        reviewListViewController.view.isHidden  = true
    }
    @IBAction func requestAction(_ sender: Any) {
       
          masterContainerController.screenType = 2
          if userType == 1 {
            masterContainerController.setupsegmentedControlCustomer()
             masterContainerController.updateViewCustomer()
              updateView(selectedView:1)
          }else{
            userViewController.view.isHidden = true
            masterContainerController.view.isHidden  = true
            reviewListViewController.view.isHidden  = false
             reviewListViewController.load_reviews()
        }
        
    }
   
    func updateView(selectedView: Int){
        if selectedView == 0 {
            userViewController.view.isHidden = false
            masterContainerController.view.isHidden  = true
        }else{
            masterContainerController.view.isHidden = false
            userViewController.view.isHidden = true
        }
    }
    func addViewControllerAsChild(childViewControllers:UIViewController){
        
        addChild(childViewControllers)
        containerView.addSubview(childViewControllers.view)
        childViewControllers.view.frame = containerView.bounds
        childViewControllers.view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        childViewControllers.didMove(toParent: self)
        
    }
    func removeViewControllerAsChild(childViewControllers:UIViewController){
        childViewControllers.willMove(toParent: nil)
        childViewControllers.view.removeFromSuperview()
        childViewControllers.removeFromParent()
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
