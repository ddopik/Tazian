//
//  tutorialViewController.swift
//  Ma7lat
//
//  Created by amr sobhy on 7/21/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import UIKit

class tutorialViewController: UIViewController  , UIScrollViewDelegate{
    var scrolls = [["image":"guide1-icon-border","body":"","title":"تزيين","color":"#E84C3D"],
                   ["image":"guide2-icon-border","body":"","title":"معتمد علي السعر","color":"#2CC1BB"],
                   ["image":"guide3-icon-border","body":"","title":"معتمد علي الموقع","color":"#F39C11"],
                   ["image":"guide4-icon-border","body":"","title":"معتمد علي التصنيف","color":"#2AB574"]]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageScrollView.contentSize = CGSize(width: self.view.bounds.size.width * 4,height: 1)
        //ic_refresh ic_star ic_dollar ic_marker_red
        imageScrollView.isPagingEnabled = true
        
        imageScrollView.showsHorizontalScrollIndicator = false
        
        loadScroll()
        skipBtn.addTarget(self, action: #selector(self.skipAction(sender:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadScroll () {
        
      //  imageScrollView.backgroundColor = UIColor(hexString:"#ebebeb")
        for (index,offer) in scrolls.enumerated() {
            if let imageScrollViewNew = Bundle.main.loadNibNamed("tutorialView", owner: self, options: nil)?.first as? tutorialView {
                imageScrollViewNew.titleLabel.text = offer["title"] as? String ?? ""
                imageScrollViewNew.bodyLabel.text = offer["body"] as? String ?? ""
                imageScrollViewNew.iconImage.image = UIImage(named:offer["image"] as? String ?? "")
                imageScrollViewNew.containerView.backgroundColor = UIColor(hexString:offer["color"]!)
                imageScrollView.addSubview(imageScrollViewNew)
                imageScrollViewNew.frame.size.width = self.imageScrollView.bounds.size.width
                imageScrollViewNew.frame.size.height = self.imageScrollView.bounds.size.height
                imageScrollViewNew.frame.origin.x = self.view.bounds.size.width * CGFloat(index)
            }
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x>0 {
            scrollView.contentOffset.x = 0
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    @IBOutlet var skipBtn: UIButton!
    @objc func skipAction(sender:UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBOutlet var imageScrollView: UIScrollView!
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
