//
//  UserModel.swift
//  barber
//
//  Created by amr sobhy on 2/26/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import Foundation
import UIKit

class Barber {
    
   
    var userID: String
    var shopname: String
    var shopID: String
    var fullname: String
    var phone: String
  
    var username: String
    var token: String
    
    var nationality: String
    var imageURL: String
    var city_price: String
    var city_rate: String
    var price: Double
    var service: Double
    var waiting: Double
    var rate: Double
    
    var priceCount: Int
    var serviceCount: Int
    var waitingCount: Int
    var rateCount: Int
    
    var isOnline: Bool
    var address: String
    var city: String
    var longtiude: AnyObject
    var latitude: AnyObject
    var shopToken: String
    var type: Int
    var isAdmin: Bool
    var membersince: AnyObject
    init?(
         userID: String,
     shopname: String,
     shopID: String,
     fullname: String,
     phone: String,
    
     username: String,
     token: String,
    
     nationality: String,
     imageURL:String,
     city_price: String,
     city_rate: String,
     price: Double,
     service: Double,
     waiting: Double,
     rate: Double,
    
     priceCount: Int,
     serviceCount: Int,
     waitingCount: Int,
     rateCount: Int,
    
     isOnline: Bool,
     address: String,
     city: String,
     longtiude: AnyObject,
     latitude: AnyObject,
     shopToken: String,
     type: Int,
     isAdmin: Bool,
     membersince: AnyObject
        ) {
        // The name must not be empty
        guard !userID.isEmpty else {
            return nil
        }
   
        self.userID = userID
        self.shopname = shopname
        self.shopID = shopID
        self.fullname = fullname
        self.phone = phone
       
        self.username = username
        self.token = token
        self.nationality = nationality
        self.imageURL = imageURL
        self.city_price = city_price
        self.city_rate = city_rate
        self.price = price
        self.service = service
        self.waiting = waiting
        self.rate = rate
        self.priceCount = priceCount
        self.serviceCount = serviceCount
        self.waitingCount = waitingCount
        self.rateCount = rateCount
        self.isOnline = isOnline
        
        self.address = address
        self.city = city
        self.longtiude = longtiude
        self.latitude = latitude
        self.shopToken = shopToken
        self.type = type
        self.isAdmin = isAdmin
        self.membersince = membersince
    }
    func getData ()->[String:AnyObject]{
        var newBarber = [String:AnyObject]()
        newBarber["userID"] = self.userID as AnyObject ?? 0.0 as AnyObject
        newBarber["shopname"] = self.shopname as AnyObject ?? 0 as AnyObject
        newBarber["shopID"] = self.shopID as AnyObject ?? 0.0 as AnyObject
        newBarber["fullname"] = self.fullname as AnyObject ?? 0 as AnyObject
        newBarber["phone"] = self.phone as AnyObject ?? 0 as AnyObject
        
        newBarber["username"] = self.username as AnyObject ?? 0 as AnyObject
        newBarber["token"] = self.token as AnyObject ?? 0 as AnyObject
        newBarber["nationality"] = self.nationality as AnyObject ?? 0 as AnyObject
        newBarber["imageURL"] = self.imageURL as AnyObject ?? "" as AnyObject
       
        newBarber["city_price"] = self.city_price as AnyObject ?? "" as AnyObject
        newBarber["city_rate"] = self.city_rate as AnyObject ?? "" as AnyObject
        newBarber["price"] = self.price as AnyObject ?? false as AnyObject
        newBarber["service"] = self.service as AnyObject ?? 0 as AnyObject
       
        newBarber["waiting"] = self.waiting as AnyObject ?? "" as AnyObject
        newBarber["rate"] = self.rate as AnyObject ?? 0.0 as AnyObject
        newBarber["priceCount"] = self.priceCount as AnyObject ?? 0 as AnyObject
        newBarber["serviceCount"] = self.serviceCount as AnyObject ?? "" as AnyObject
       
        newBarber["waitingCount"] = self.waitingCount as AnyObject ?? "" as AnyObject
        newBarber["rateCount"] = self.rateCount as AnyObject ?? 0 as AnyObject
        newBarber["isOnline"] = self.isOnline as AnyObject ?? "" as AnyObject
        newBarber["address"] = self.address as AnyObject ?? "" as AnyObject
       
        newBarber["city"] = self.city as AnyObject ?? "" as AnyObject
        newBarber["longtiude"] = self.longtiude as AnyObject ?? "" as AnyObject
        newBarber["latitude"] = self.latitude as AnyObject ?? "" as AnyObject
        newBarber["shopToken"] = self.shopToken as AnyObject ?? "" as AnyObject
        
        newBarber["type"] = self.type as AnyObject ?? "" as AnyObject
        newBarber["isAdmin"] = self.isAdmin as AnyObject ?? "" as AnyObject
        newBarber["membersince"] = self.membersince as AnyObject ?? "" as AnyObject
        
        return newBarber
    }
    
}




