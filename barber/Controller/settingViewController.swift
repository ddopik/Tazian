//
//  settingViewController.swift
//  barber
//
//  Created by amr sobhy on 3/27/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class settingViewController: UIViewController ,UITableViewDataSource ,UITableViewDelegate{
    
    
    @IBOutlet weak var mainContainer: UIView!
    
    @IBOutlet weak var settingTableView: UITableView!
    let setting_data = ["Select Language","Feedback","Request a New Feature","Sign Out"]
    let setting_image = ["ic_select_language","ic_feedback","ic_feature","ic_sign_out"]
    override func viewDidLoad() {
        super.viewDidLoad()
         self.navigationController?.navigationBar.isHidden = false
        self.settingTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
        mainContainer.ViewborderRound(border: 0.3, corner: 20)
        settingTableView.ViewborderRound(border: 0.3, corner: 20)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setting_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as? settingCellTableViewCell
        cell?.actionBtn.setTitle(setting_data[indexPath.row], for: .normal)
       
        cell?.settingImg.image = UIImage(named:setting_image[indexPath.row])
        if indexPath.row == 3 { 
            cell?.actionBtn.addTarget(self, action: #selector(self.logout(sender:)), for: .touchUpInside)
        }
        return cell!
    }
    
    @objc func logout (sender:UIButton){
        removeUserData()
        var firstScreen = self.storyboard?.instantiateViewController(withIdentifier: "splashScreenView") as? SplashScreenViewController
        self.navigationController?.pushViewController(firstScreen!, animated: true)
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
