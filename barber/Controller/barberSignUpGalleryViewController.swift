//
//  barberSignUpGalleryViewController.swift
//  barber
//
//  Created by amr sobhy on 3/28/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class barberSignUpGalleryViewController: UIViewController {

    @IBOutlet weak var importGallery: UIButton!
    
    @IBOutlet weak var cameraBtn: UIButton!
    
    @IBOutlet weak var skipBtn: UIButton!
    
    @IBOutlet weak var nextBtn: UIButton!
    
    override func viewDidLoad() {
        importGallery.ButtonborderRound()
        cameraBtn.ButtonborderRound()
        skipBtn.ButtonborderRound()
        nextBtn.ButtonborderRound()
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBAction func importGalleryAction(_ sender: Any) {
    }
    
    @IBAction func cameraAction(_ sender: Any) {
    }
    
    @IBAction func skipAction(_ sender: Any) {
        var masterScreen = self.storyboard?.instantiateViewController(withIdentifier: "masterHomeView") as? masterHomeViewController
        self.navigationController?.pushViewController(masterScreen!, animated: true)
    }
    
    @IBAction func nextAction(_ sender: Any) {
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
