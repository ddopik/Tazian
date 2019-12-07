//
//  Utitlites.swift
//  Expand
//
//  Created by amr sobhy on 10/15/17.
//  Copyright © 2017 amr sobhy. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}

//##f1f1f1
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
extension String {
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    //Validate Email
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){
                
                if(self.count>=6 && self.count<=20){
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
}

extension UILabel {
    
    func alignLabel() {
        if UserDataStorage.getLang() == "en" {
            self.textAlignment = NSTextAlignment.left
        }else{
            self.textAlignment = NSTextAlignment.right
        }
    }
}
extension UITextField {
    func TextsetBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    func TextborderRound(corner:CGFloat = 20.0 , borderWidth:CGFloat=0.5){
        let myColor = UIColor.clear
        self.layer.borderColor = myColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = corner
    }
    func TextborderRound(corner:CGFloat = 20.0){
        let myColor = UIColor.clear
        self.layer.borderColor = myColor.cgColor
        self.layer.borderWidth = 0.7
        self.layer.cornerRadius = corner
    }
    func placeholderColor (){
        let color = UIColor.red
        self.attributedPlaceholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : color])
    }
}
extension UIView {
    func ViewborderRound(border:CGFloat,corner:CGFloat){
        let myColor = UIColor.clear
        self.layer.borderColor = myColor.cgColor
        self.layer.borderWidth = border
        self.layer.cornerRadius = corner
    }
    func ViewdropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 0.5
        
    }
    
    // OUTPUT 2
    func ViewdropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}

extension UIImageView {
    func ImageBorderRadius(border:CGFloat,corner:CGFloat){
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = border
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = corner
        //  self.layer.clipsToBounds = true
    }
    func ImageBorderCircle(){
        
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        //  self.layer.clipsToBounds = true
    }
}
extension UIImage {
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}

extension UISegmentedControl{
    func segementCornerRadius(){
        self.layer.cornerRadius = 10.0;
        self.layer.borderColor = UIColor.clear.cgColor;
        self.layer.borderWidth = 1.0;
        self.layer.masksToBounds = true
    }
    func removeBorder(color:CGColor = UIColor.white.cgColor){
        let backgroundImage = UIImage.getColoredRectImageWith(color: color, andSize: self.bounds.size)
        let backgroundImageselected = UIImage.getColoredRectImageWith(color: UIColor.clear.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImageselected, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.clear.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        
        
    }
    
    func addUnderlineForSelectedSegment(){
        removeBorder(color:UIColor.clear.cgColor)
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 4.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor.orange
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}
extension UIButton {
    
    func ButtonborderRound() {
        let myColor = UIColor.clear
        self.layer.borderColor = myColor.cgColor
        self.layer.borderWidth = 0.7
        self.layer.cornerRadius = 20.0
    }
    
    func ButtonborderRoundradius(radius :Float) {
        let myColor = UIColor.clear
        self.layer.borderColor = myColor.cgColor
        self.layer.borderWidth = 0.7
        self.layer.cornerRadius = CGFloat(radius)
    }
    func ButtonCircular (){
        
        self.layer.cornerRadius = 0.5 * self.bounds.size.width
        self.clipsToBounds = true
    }
    func imageAboveText(padding: CGFloat = 6.0) {
        guard
            let imageViewSize = self.imageView?.frame.size,
            let titleLabelSize = self.titleLabel?.frame.size else {
                return
        }
        
        let totalHeight = imageViewSize.height + titleLabelSize.height + padding
        
        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageViewSize.height),
            left: 0.0,
            bottom: 0.0,
            right: -titleLabelSize.width
        )
        
        self.titleEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: -imageViewSize.width,
            bottom: -(totalHeight - titleLabelSize.height),
            right: 0.0
        )
        
        self.contentEdgeInsets = UIEdgeInsets(
            top: 0.0,
            left: 0.0,
            bottom: titleLabelSize.height,
            right: 0.0
        )
    }
}

extension NSURL {
    var fragments: [String: String] {
        var results = [String: String]()
        if let pairs = self.fragment?.components(separatedBy: "&"), pairs.count > 0 {
            for pair: String in pairs {
                if let keyValue = pair.components(separatedBy: "=") as [String]? {
                    results.updateValue(keyValue[1], forKey: keyValue[0])
                }
            }
        }
        return results
    }
}

func calc_sale(old:String , saving:String )->String{
    
    var sale = CGFloat(Float(old)!) - CGFloat(Float(saving)!)
    sale = ( sale / CGFloat(Float(old)!) ) * 100
    return "\(sale)"
    
}
class Utilities: NSObject {
    
    
    class func isEmailValidation(_ email:String)->Bool{
        let emailRegularExpretion = "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegularExpretion)
        return emailTest.evaluate(with: email)
    }
}

class UserDataStorage: NSObject {
    
    
    class func checkUserLogin() -> Bool{
        let defaults: UserDefaults = UserDefaults.standard
        var isLogin :Bool = false
        if let checkLogin = defaults.object(forKey: "userLogin") as? Bool{
            isLogin = checkLogin
        }
        return isLogin
    }
    
    class func getLang() -> String{
        let defaults: UserDefaults = UserDefaults.standard
        var lang = ""
        if let checkLang = defaults.object(forKey: "lang") as? String{
            lang = checkLang
        }
        return lang
    }
    
    class func setLang(lang:String) -> String{
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(lang, forKey: "lang")
        defaults.synchronize()
        return lang
    }
    class func setUserLogin(isLogin: Bool){
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(isLogin, forKey: "userLogin")
        
        defaults.synchronize()
    }
    
    class func setToken(token: String){
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(token, forKey: "token")
        
        defaults.synchronize()
    }
    class func checkToken() -> Bool{
        let defaults: UserDefaults = UserDefaults.standard
        var isToken :Bool = false
        if let checktoken = defaults.object(forKey: "token") as? String{
            isToken = true
        }
        return isToken
    }
    class func getToken() -> String{
        let defaults: UserDefaults = UserDefaults.standard
        var token = ""
        if let checktoken = defaults.object(forKey: "token") as? String{
            token = checktoken
        }
        return token
    }
    
    
}
func convertTimestamp(serverTimestamp: Double) -> String {
    let x = serverTimestamp / 1000
    let date = NSDate(timeIntervalSince1970: x)
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .medium
    
    return formatter.string(from: date as Date)
}
func checkimageURL (checkString:String) -> URL{
    
    if let imageURL = URL(string: checkString) as? URL {
        
        return imageURL
        
    }else{
        let url = URL(string: "")
        return url!
    }
}

func calculateDistanceInMiles(from :CLLocation , to:CLLocation) ->String{
    
    let distanceInMeters = from.distance(from: to)
    if(distanceInMeters <= 1000)
    {
        return "Less than 1 Kilo"
    }
    else
    {
        return "Less than \(distanceInMeters / 1000 ) "
        
    }
}
func global_check_location(controler:UIViewController){
    let locationManager = CLLocationManager()
    
    locationManager.delegate = controler as! CLLocationManagerDelegate
    
    
    
    
    switch CLLocationManager.authorizationStatus() {
    case .notDetermined, .restricted, .denied:
        print("No access")
        locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        locationManager.requestWhenInUseAuthorization()
        return
        
    case .authorizedWhenInUse ,.authorizedAlways:
        // Enable basic location features
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = controler as! CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            if let position = locationManager.location?.coordinate as? CLLocationCoordinate2D  {
                let geocoder = GMSGeocoder()
                myLocation.longtide = position.longitude
                
                myLocation.latitude = position.latitude
                geocoder.reverseGeocodeCoordinate(position) { response, error in
                    guard let address = response?.firstResult(), let lines = address.lines else {
                        return
                    }
                    print(address)
                    print(lines)
                    
                    myLocation.city = address.administrativeArea as? String ?? ""
                    myLocation.address =  lines.joined(separator: " , ")
                }
                
                // 2
            }
            print(myLocation)
            
            
        }else{
            let alertController = UIAlertController(title: NSLocalizedString("تنبية", comment: ""), message: NSLocalizedString("يجب السماح بتحديد المكان", comment: ""), preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: NSLocalizedString("الغاء", comment: ""), style: .cancel, handler: nil)
            let settingsAction = UIAlertAction(title: NSLocalizedString("الاعدادات", comment: ""), style: .default) { (UIAlertAction) in
                UIApplication.shared.openURL(NSURL(string: UIApplication.openSettingsURLString)! as URL)
            }
            
            print("test")
            alertController.addAction(cancelAction)
            alertController.addAction(settingsAction)
            controler.present(alertController, animated: true, completion: nil)
            
        }
        
        
        
    }
    
    
    
    
    
}
func global_showMarker (mapView:GMSMapView,title:String,lat:Double,long:Double,iconColor:UIColor,imageName:String){
    let delivery_marker = GMSMarker()
    delivery_marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
    delivery_marker.title = title
    
    delivery_marker.snippet = ""
    delivery_marker.icon = GMSMarker.markerImage(with: iconColor)
    let markerImage = UIImage(named: imageName)!.withRenderingMode(.alwaysTemplate)
    
    
    //creating a marker view
    let markerView = UIImageView(image: markerImage)
    markerView.contentMode = UIView.ContentMode.scaleAspectFit
    
    markerView.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
    //changing the tint color of the image
    markerView.tintColor = iconColor
    delivery_marker.iconView =  markerView
    
    delivery_marker.map = mapView
}



