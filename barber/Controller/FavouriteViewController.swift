//
//  FavouriteViewController.swift
//  barber
//
//  Created by amr sobhy on 4/1/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import FirebaseDatabaseUI
import Firebase
import Toast
import MBProgressHUD
class FavouriteViewController: UIViewController ,  UITableViewDelegate ,UITableViewDataSource{
    
    
    var ref : DatabaseReference!
    var databaseHandler: DatabaseHandle!
    var favouriteArray = [Dictionary<String,AnyObject>]()
    var favouriteKey = [String]()
    @IBOutlet weak var favouriteTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        favouriteArray.removeAll()
       // favouriteTableView.separatorStyle = .none
    
      
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouriteArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! FavouriteTableViewCell
        cell.barberName.text = favouriteArray[indexPath.row]["username"] as! String
        cell.shopName.text = favouriteArray[indexPath.row]["shopname"] as! String
       cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.addTarget(self, action: #selector(self.deleteBarber), for: .touchUpInside)
        cell.containerView.ViewborderRound(border: 0.5, corner: 10.0)
        return cell
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func deleteBarber (sender: UIButton){
        
    }
    func load_requests(){
        self.favouriteArray.removeAll()
          self.favouriteKey.removeAll()
        MBProgressHUD.showAdded(to: self.view, animated: true)
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
                            self.favouriteTableView.reloadData()
                        }
                        print(self.favouriteArray)
                    })
                    { (err) in
                        MBProgressHUD.hide(for: self.view, animated: true)
                        
                    }
                }
               
            }
            
            
        })
        { (err) in
          
            
        }
        
         MBProgressHUD.hide(for: self.view, animated: true)
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
