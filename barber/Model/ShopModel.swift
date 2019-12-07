//
//  UserModel.swift
//  barber
//
//  Created by amr sobhy on 2/26/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import Foundation
import UIKit

class Shop {
    
    
    var isAdmin: Bool
    var membersince: AnyObject
    var isOnline: Bool
    var imageURL1: String
    var imageURL2: String
    var imageURL3: String
    var imageURL4: String
    var shopID: String
    
    var token: String
    var personInCharge: String
    var title: String
    var phone: String
    var cr_number: String
    var address: String
    var city: String
    var longtude: Double
    var latitude: Double
   
    var type: Int
    var price: Double
    var service: Double
    var waiting: Double
    var rate: Double
    init?(
         isAdmin: Bool,
     membersince: AnyObject,
     isOnline: Bool,
     imageURL1: String,
     imageURL2: String,
     imageURL3: String,
     imageURL4: String,
     shopID: String,
    
     token: String,
     personInCharge: String,
     title: String,
     phone: String,
     cr_number: String,
     address: String,
     city: String,
     longtude: Double,
     latitude: Double,
    
     type: Int,
     price: Double,
     service: Double,
     waiting: Double,
     rate: Double
        ) {
        // The name must not be empty
        guard !shopID.isEmpty else {
            return nil
        }
        self.isAdmin = isAdmin
        self.membersince = membersince
        self.isOnline = isOnline
        self.imageURL1 = imageURL1
         self.imageURL2 = imageURL2
         self.imageURL3 = imageURL3
         self.imageURL4 = imageURL4
        self.shopID = shopID
        self.token = token
        self.personInCharge = personInCharge
        self.title = title
        self.phone = phone
        self.cr_number = cr_number
        self.address = address
        self.city = city
        self.longtude = longtude
        self.latitude = latitude
        self.type = type
        self.price = price
        self.service = service
        self.waiting = waiting
        self.rate = rate
    }
    func getData ()->[String:AnyObject]{
        var newShop = [String:AnyObject]()
        newShop["isAdmin"] = self.isAdmin as AnyObject ?? 0.0 as AnyObject
        newShop["membersince"] = self.membersince as AnyObject ?? 0 as AnyObject
        newShop["isOnline"] = self.isOnline as AnyObject ?? 0.0 as AnyObject
        newShop["imageURL1"] = self.imageURL1 as AnyObject ?? 0 as AnyObject
        newShop["imageURL2"] = self.imageURL2 as AnyObject ?? 0 as AnyObject
        newShop["imageURL3"] = self.imageURL3 as AnyObject ?? 0 as AnyObject
        newShop["imageURL4"] = self.imageURL4 as AnyObject ?? 0 as AnyObject
        newShop["shopID"] = self.shopID as AnyObject ?? "" as AnyObject
        newShop["token"] = self.token as AnyObject ?? "" as AnyObject
        newShop["personInCharge"] = self.personInCharge as AnyObject ?? "" as AnyObject
        newShop["title"] = self.title as AnyObject ?? false as AnyObject
        newShop["phone"] = self.phone as AnyObject ?? 0 as AnyObject
        newShop["cr_number"] = self.cr_number as AnyObject ?? "" as AnyObject
        newShop["address"] = self.address as AnyObject ?? 0.0 as AnyObject
        newShop["city"] = self.city as AnyObject ?? 0 as AnyObject
        newShop["longtude"] = self.longtude as AnyObject ?? "" as AnyObject
        newShop["latitude"] = self.latitude as AnyObject ?? "" as AnyObject
        newShop["type"] = self.type as AnyObject ?? 0 as AnyObject
        newShop["price"] = self.price as AnyObject ?? "" as AnyObject
        newShop["service"] = self.service as AnyObject ?? "" as AnyObject
         newShop["waiting"] = self.waiting as AnyObject ?? "" as AnyObject
         newShop["rate"] = self.rate as AnyObject ?? "" as AnyObject
        
        return newShop
    }
    
}



