//
//  MasterContainerViewController.swift
//  barber
//
//  Created by amr sobhy on 3/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class MasterContainerViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var segment: UISegmentedControl!
    var screenType: Int!
    // Mark views for customer when select request scene number 2 (Home View) :
    lazy var firstViewController : FirstViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "firstViewController") as! FirstViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    lazy var secondViewController : secondViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "secondViewController") as! secondViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    lazy var thirdViewController : thirdViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "thirdViewController") as! thirdViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    //Mark End for Home View
    
    // Mark views for customer when select request scene number 3 (Request View) :
    lazy var favouriteViewController : FavouriteViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "favouriteView") as! FavouriteViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    // Mark request is made for customer and barber to load recent requests
    lazy var barberRequestViewController : barberRequestsViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "barberRequestView") as! barberRequestsViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    
    lazy var reviewListViewController : reviewListViewController = {
        let storyboard = UIStoryboard(name:"Main",bundle:Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "reviewListView") as! reviewListViewController
        self.addViewControllerAsChild(childViewControllers:viewController)
        return viewController
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.segment.segementCornerRadius()
        if userType == 1 {
            setupsegmentedControlCustomer()
            updateViewCustomer()
        } else if userType == 2 {
            setupsegmentedControlBarber()
             barberRequestViewController.requestCompleted = false
            updateViewBarber()
        }
        else if userType == 3 {
            setupsegmentedControlShop()
            barberRequestViewController.requestCompleted = false
            updateViewBarber()
        }
        self.navigationController?.navigationBar.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.red], for: .selected)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK : - setup segment change
    public  func setupsegmentedControlCustomer(){
        self.segment.removeAllSegments()
        var first = "" ; var second = "";var third = "";var fourth=""
        
        if screenType == 1{
            first = "Single"
            second = "List"
            third = "Map"
            self.segment.insertSegment(withTitle: first, at: 0, animated: true)
            self.segment.insertSegment(withTitle: second, at: 1, animated: true)
            self.segment.insertSegment(withTitle: third, at: 2, animated: true)
            self.segment.isHidden = true
        }else{
            first = "Requests"
            second = "History"
             third = "Review"
            fourth = "Favourites"
            self.segment.isHidden = false
            self.segment.insertSegment(withTitle: first, at: 0, animated: true)
            self.segment.insertSegment(withTitle: second, at: 1, animated: true)
            self.segment.insertSegment(withTitle: third, at: 2, animated: true)
            self.segment.insertSegment(withTitle: fourth, at: 3, animated: true)
        }
        
        self.segment.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        self.segment.selectedSegmentIndex = 0
    }
    private  func setupsegmentedControlBarber(){
        self.segment.removeAllSegments()
        self.segment.insertSegment(withTitle: "Active", at: 0, animated: true)
        self.segment.insertSegment(withTitle: "Completed", at: 1, animated: true)
        self.segment.insertSegment(withTitle: "Reviews", at: 2, animated: true)
        self.segment.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        self.segment.selectedSegmentIndex = 0
    }
    
    private  func setupsegmentedControlShop(){
        self.segment.removeAllSegments()
        self.segment.insertSegment(withTitle: "First", at: 0, animated: true)
        self.segment.insertSegment(withTitle: "Second", at: 1, animated: true)
        self.segment.insertSegment(withTitle: "Third", at: 2, animated: true)

        self.segment.addTarget(self, action: #selector(selectionDidChange(sender:)), for: .valueChanged)
        self.segment.selectedSegmentIndex = 0
    }
    
    @objc  func selectionDidChange(sender:UISegmentedControl){
        var selectedIndex = sender.selectedSegmentIndex
        if userType == 1 {
               if screenType == 1{
                segment.isHidden = true
               }else{
                segment.isHidden = false

            }
            self.updateViewCustomer()
            if screenType == 1{
                
            }else{
                if  selectedIndex == 0 {
                    barberRequestViewController.load_requests()
                }else if selectedIndex == 2 {
                    barberRequestViewController.load_reviews()
                }
            }
            
        }
        else if userType == 2 {
            if sender.selectedSegmentIndex == 0 {
                barberRequestViewController.requestCompleted = false
                
            }
            else if selectedIndex == 2 {
                barberRequestViewController.load_reviews()
            }
            else{
                barberRequestViewController.requestCompleted = true
                
            }
           
            self.updateViewBarber()
        }
        else if userType == 3 {
            barberRequestViewController.selectedBarberIndex = sender.selectedSegmentIndex

            
            self.updateViewBarber()
        }
        
    }
    
    func updateViewCustomer(){
        if screenType == 1 {
            favouriteViewController.view.isHidden = true
            barberRequestViewController.view.isHidden = true
            reviewListViewController.view.isHidden = true
            firstViewController.view.isHidden = !(segment.selectedSegmentIndex == 0)
            secondViewController.view.isHidden = !(segment.selectedSegmentIndex == 1)
            thirdViewController.view.isHidden = !(segment.selectedSegmentIndex == 2)
           
        }else {
            firstViewController.view.isHidden = true
            secondViewController.view.isHidden = true
            thirdViewController.view.isHidden = true
            if segment.selectedSegmentIndex == 0 {
                 barberRequestViewController.view.isHidden = false
                reviewListViewController.view.isHidden = true
                favouriteViewController.view.isHidden = true
                barberRequestViewController.load_requests()
            }
            else if segment.selectedSegmentIndex == 1 {
                barberRequestViewController.view.isHidden = false
                reviewListViewController.view.isHidden = true
                favouriteViewController.view.isHidden = true
                barberRequestViewController.load_requests()
            }
            else if segment.selectedSegmentIndex == 2 {
                favouriteViewController.view.isHidden = true
                barberRequestViewController.view.isHidden = true
                reviewListViewController.view.isHidden = false
                reviewListViewController.load_reviews()
            }else{
                barberRequestViewController.view.isHidden = true
                reviewListViewController.view.isHidden = true
                favouriteViewController.view.isHidden = false
                favouriteViewController.load_requests()
            }
        }
    }
    func updateViewBarber(){
        barberRequestViewController.view.isHidden = false
        barberRequestViewController.load_requests()
        
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
