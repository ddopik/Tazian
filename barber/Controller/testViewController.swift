//
//  testViewController.swift
//  barber
//
//  Created by amr sobhy on 3/25/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class testViewController: UIViewController {

    @IBOutlet weak var barberScrollView: UIScrollView!
    let barber1 = ["name":"barber1","username":"amrbarber","city":"city"]
    let barber2 = ["name":"barber2","username":"amrbarber2","city":"city2"]
    let barber3 = ["name":"barber3","username":"amrbarber3","city":"city3"]
    var barbers = [Dictionary<String,String>]()
    override func viewDidLoad() {
        super.viewDidLoad()
        barbers = [barber1,barber2,barber3]
       
        barberScrollView.contentSize = CGSize(width: self.view.bounds.size.width * CGFloat(barbers.count),height: self.view.bounds.height / 2)
        barberScrollView.isPagingEnabled = true
        barberScrollView.showsHorizontalScrollIndicator = false
        barberScrollView.frame.origin.y = 200
        barberScrollView.frame.origin.x = 0
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if let barberViewnew = Bundle.main.loadNibNamed("Barber", owner: self, options: nil)?.first as? barberView {
            //   barberViewnew.nameLabel.text = barber["name"]
            //  barberViewnew.usernameLabel.text = barber["username"]
            // barberViewnew.addressLabel.text = barber["city"]
          //
            barberViewnew.frame.size.width = self.view.bounds.size.width
           barberViewnew.frame.origin.x = 0
          //  self.view.addSubview(barberViewnew)
            barberScrollView.addSubview(barberViewnew)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadBarbers(){
        for (index,barber) in barbers.enumerated() {
            
            if let barberViewnew = Bundle.main.loadNibNamed("Barber", owner: self, options: nil)?.first as? barberView {
                //   barberViewnew.nameLabel.text = barber["name"]
                //  barberViewnew.usernameLabel.text = barber["username"]
                // barberViewnew.addressLabel.text = barber["city"]
                barberScrollView.addSubview(barberViewnew)
                // barberViewnew.frame.size.width = self.view.bounds.size.width
                // barberViewnew.frame.origin.x = self.view.bounds.size.width * CGFloat(index)
                
            }
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
