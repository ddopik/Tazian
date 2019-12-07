//
//  parentChatViewController.swift
//  Mazad
//
//  Created by amr sobhy on 5/7/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit
import Toast
import MBProgressHUD
import Firebase
import FirebaseDatabaseUI
class parentChatViewController: UIViewController {
    var chat_id = ""
    var otherId = ""
    var otherName = ""
    var requestID = ""
    var chat = [String:Any]()
    var ref : DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        // Do any additional setup after loading the view.
        loadMsg()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = otherName
          self.navigationController?.navigationBar.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor(hexString:navigationColorCode)
        self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
        self.view.layer.borderColor = UIColor.clear.cgColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        // UINavigationBar.appearance(). = [NSForegroundColorAttributeName: UIColor.white]
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor(hexString: navigationColorCode)
        
    }
   
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.navigationBar.plainView.semanticContentAttribute = .forceLeftToRight
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        loadMsg()
        if segue.identifier == "embedChat" ,
            let nextScene = segue.destination as? chatViewController  {
           
            nextScene.chat_id = self.requestID
            nextScene.otherId = chat["messageUserId"] as? String ?? ""
            nextScene.otherName = chat["messageUser"] as? String ?? ""
            nextScene.requestID = self.requestID
        }
    }
    func loadMsg (){
        
        ref = Database.database().reference()
        self.ref.child("chat").child(requestID).observe(.childAdded, with: {(snapshot) in
            
            if let check = snapshot.value as? [String:Any]{
                self.chat = check
                return
               
            }else{
                print("snapshot.value\(snapshot.value)")
            }
        })
        { (err) in
            self.view.makeToast("there is no requests")
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
