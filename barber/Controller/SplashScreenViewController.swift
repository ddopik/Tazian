//
//  SplashScreenViewController.swift
//  barber
//
//  Created by amr sobhy on 2/24/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import GoogleMaps
class SplashScreenViewController: UIViewController , CLLocationManagerDelegate  {
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        checkLocationPrivacy()

      
        self.navigationController?.navigationBar.isHidden = true
    }
    @objc func splashTimeOut(sender : Timer){
        let checkData = checkUserData()
        print(checkData)
        print(myLocation.latitude)
        if checkUserData() {
           loadUserData()
               print(userData)
                userType = userData["type"] as? Int ?? 0
            node = (userType == 1) ? "customers" : "barbers"
            print(userType)
            
               //masterHomeView
            self.performSegue(withIdentifier: "showMainHome", sender: nil)
             //   self.navigationController?.pushViewController(masterScreen!, animated: true)
  /*
            let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "mainScreenView") as? MainScreenViewController
            self.navigationController?.pushViewController(mainScreen!, animated: true)
            */
        }else{
            let mainScreen = self.storyboard?.instantiateViewController(withIdentifier: "mainScreenView") as? MainScreenViewController
            self.navigationController?.pushViewController(mainScreen!, animated: true)
        }
    }
    func checkLocationPrivacy(){
        if CLLocationManager.locationServicesEnabled() {
            global_check_location(controler: self)
              Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.splashTimeOut(sender:)), userInfo: nil, repeats: false)
            self.navigationItem.title = ""
        }else{
            global_check_location(controler: self)
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
