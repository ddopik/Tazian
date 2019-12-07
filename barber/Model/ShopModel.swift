//
//  UserModel.swift
//  barber
//
//  Created by amr sobhy on 2/26/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import Foundation
import UIKit
struct userModel {
    var userName = ""
    // var profileImage : UIImage = UIImage()
    var userID = ""
    var userPhoneNumber = ""
    var userEmail = ""
    var userPassword = ""
    var role  = 0
}

func arraySaveData(usermodel :[String:AnyObject]) -> [String:AnyObject]{
    var newUser = [String:AnyObject]()
    newUser["userId"] = usermodel["name"] as AnyObject ?? "" as AnyObject
    newUser["userId"] = usermodel["name"] as AnyObject ?? "" as AnyObject
    newUser["userId"] = "" as AnyObject
    newUser["userId"] = "" as AnyObject
    newUser["userId"] = "" as AnyObject
    
    return newUser
}
func saveUserData() {
    
    if #available(iOS 10.0, *) {
        let delegate =  UIApplication.shared.delegate as! AppDelegate
        UserDefaults.standard.set(delegate.appUser.userPassword, forKey: "password")
        UserDefaults.standard.set(delegate.appUser.userID, forKey: "ID")
        UserDefaults.standard.set(delegate.appUser.userName, forKey: "name")
        UserDefaults.standard.set(delegate.appUser.userPhoneNumber, forKey: "mobile")
        UserDefaults.standard.set(delegate.appUser.userEmail, forKey: "email")
        UserDefaults.standard.set(delegate.appUser.role, forKey: "role")
        
        UserDefaults.standard.synchronize()
    } else {
        // Fallback on earlier versions
    }
    
    
}

func saveImage (image: UIImage, imageName: String ) -> Bool{
    
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let getImagePath = paths.appending("/\(imageName)")
    let checkValidation = FileManager.default
    
    if (checkValidation.fileExists(atPath: getImagePath))
    {
        print("amr")
        print(getImagePath)
        //remove file as its already existed
        // try! // checkValidation.removeItem(atPath: getImagePath)
    }
    else
    {
        print("saved URl \(getImagePath)")
        let imgData = UIImageJPEGRepresentation(image, 0.5)!
        //write file as its not available
        try! imgData.write(to: URL.init(fileURLWithPath: getImagePath), options: .atomicWrite)
        
    }
    return true
}
func checkImageexist (id :String) -> String{
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
    let getImagePath = paths.appending("/\(id).png")
    let checkValidation = FileManager.default
    print("checLfunction")
    print(getImagePath)
    if (checkValidation.fileExists(atPath: getImagePath))
    {
        print("amr")
        print(getImagePath)
        return getImagePath
        //remove file as its already existed
        // try! // checkValidation.removeItem(atPath: getImagePath)
    } else{
        return "no"
    }
}
@available(iOS 10.0, *)
func loadUserData() {
    let delegate =  UIApplication.shared.delegate as! AppDelegate
    
    var user = userModel()
    user.userPassword = UserDefaults.standard.value(forKey: "password") as? String ?? ""
    user.userEmail = UserDefaults.standard.value(forKey: "email") as? String ?? ""
    user.userID = UserDefaults.standard.value(forKey: "ID") as? String ?? ""
    user.userName = UserDefaults.standard.value(forKey: "name") as? String ?? ""
    user.userPhoneNumber = UserDefaults.standard.value(forKey: "mobile") as? String ?? ""
    user.role = UserDefaults.standard.value(forKey: "role") as? Int ?? 0
    
    delegate.appUser = user
    
}

func removeUserData(){
    let defaults: UserDefaults = UserDefaults.standard
    
    defaults.removeObject(forKey: "password")
    defaults.removeObject(forKey: "email")
    defaults.removeObject(forKey: "ID")
    defaults.removeObject(forKey: "name")
    defaults.removeObject(forKey: "mobile")
    
    defaults.synchronize()
}
class Shop {
    
    //MARK: Properties
    
    var attendance: Float
    var attendanceCount: Int
    var behavior: Float
    var behaviorCount: Int
    var email: String
    var fullname: String
    var imageURL: String
    var isOnline: Bool
    var membersince: Int
    var nationality: String
    var overallRating: Float
    var overallRatingCount: Int
    var phone: String
    var token: String
    var type: Int
    var userID: String
    var username: String
    init?(attendance: Float, attendanceCount: Int, behavior: Float,
          behaviorCount: Int, email: String, fullname: String,
          imageURL: String, isOnline: Bool, membersince: Int,
          nationality: String, overallRating: Float, overallRatingCount: Int,
          phone: String, token: String, type: Int,
          userID: String, username: String
        ) {
        // The name must not be empty
        guard !userID.isEmpty else {
            return nil
        }
        self.attendance = attendance
        self.attendanceCount = attendanceCount
        self.behavior = behavior
        self.behaviorCount = behaviorCount
        self.email = email
        self.fullname = fullname
        self.imageURL = imageURL
        self.isOnline = isOnline
        self.membersince = membersince
        self.nationality = nationality
        self.overallRating = overallRating
        self.overallRatingCount = overallRatingCount
        self.phone = phone
        self.token = token
        self.type = type
        self.userID = userID
        self.username = username
    }
    func getData ()->[String:AnyObject]{
        var newUser = [String:AnyObject]()
        newUser["attendance"] = self.attendance as AnyObject ?? 0.0 as AnyObject
        newUser["attendanceCount"] = self.attendanceCount as AnyObject ?? 0 as AnyObject
        newUser["behavior"] = self.behavior as AnyObject ?? 0.0 as AnyObject
        newUser["behaviorCount"] = self.behaviorCount as AnyObject ?? 0 as AnyObject
        newUser["email"] = self.email as AnyObject ?? "" as AnyObject
        newUser["fullname"] = self.fullname as AnyObject ?? "" as AnyObject
        newUser["imageURL"] = self.imageURL as AnyObject ?? "" as AnyObject
        newUser["isOnline"] = self.isOnline as AnyObject ?? false as AnyObject
        newUser["membersince"] = self.membersince as AnyObject ?? 0 as AnyObject
        newUser["nationality"] = self.nationality as AnyObject ?? "" as AnyObject
        newUser["overallRating"] = self.attendance as AnyObject ?? 0.0 as AnyObject
        newUser["overallRatingCount"] = self.overallRatingCount as AnyObject ?? 0 as AnyObject
        newUser["phone"] = self.phone as AnyObject ?? "" as AnyObject
        newUser["token"] = self.token as AnyObject ?? "" as AnyObject
        newUser["type"] = self.type as AnyObject ?? 0 as AnyObject
        newUser["userID"] = self.userID as AnyObject ?? "" as AnyObject
        newUser["username"] = self.username as AnyObject ?? "" as AnyObject
        return newUser
    }
    
}



