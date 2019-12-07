//
//  secondViewController.swift
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

class secondViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    var list = [Dictionary<String,Any>]()
    var ref : DatabaseReference!
    var nodeType = "shops"
    
    @IBOutlet weak var userType: UISegmentedControl!
    @IBOutlet weak var listType: UISegmentedControl!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewCell") as? listViewTableViewCell
        if nodeType == "shops"{
            cell?.nameLabel.text = list[indexPath.row]["title"] as? String ?? ""
           // cell?.nameLabel.text = list[indexPath.row]["personInCharge"] as? String ?? ""
            
        }else{
           cell?.nameLabel.text = list[indexPath.row]["username"] as? String ?? ""
          //  barberViewnew.usernameLabel.text = list[indexPath.row]["shopname"] as? String ?? ""
            
        }
      //  cell?.nameLabel.text = list[indexPath.row]["title"] as? String ?? ""
        cell?.dateLabel.text = convertTimestamp(serverTimestamp: list[indexPath.row]["membersince"] as? Double ?? 0.0)
        cell?.addressLabel.text = list[indexPath.row]["address"] as? String ?? ""
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 137
    }
    
    @IBAction func listAction(_ sender: Any) {
    }
    
    @IBAction func userActionType(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            nodeType = "shops"
        } else {
            nodeType = "barbers"
        }
        load_list()
    }
    @IBOutlet weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        load_list()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func load_list(){
        self.list.removeAll()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.ref.child("users").child(nodeType).observe(.childAdded, with: {(snapshot) in
            // Mark - Check to get request for customer or Barber
            if let checkRequest = snapshot.value as? [String:AnyObject]{
                self.list.append(checkRequest)
                print(self.list)
                
                MBProgressHUD.hide(for: self.view, animated: true)
                self.listTableView.reloadData()
            }else{
                print("snapshot.value\(snapshot.value)")
            }
        })
        { (err) in
            MBProgressHUD.hide(for: self.view, animated: true)
           
        }
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
