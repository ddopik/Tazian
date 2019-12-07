//
//  RequestModel.swift
//  barber
//
//  Created by amr sobhy on 3/26/18.
//  Copyright © 2018 amr sobhy. All rights reserved.
//

import Foundation
import UIKit
class Requests {
    
    //MARK: Properties
    
    var requestID :String
    var customerID :String
    var customerName :String
    var customerToken :String
    var customerImageURL :String
    var barberID :String
    var barberName :String
    var barberToken :String
    var barberImageURL :String
    var barberShopName :String
    var requestTime :AnyObject
    var timeorder :AnyObject
    var customerComment :String
    var barberComment :String
    
    var customerAnswered :Bool
    var barberAnswered :Bool
    var complete :Bool
    var customerReviewed :Bool
    var barberReviewed :Bool
    var canceled :Bool
    var customerChangeTime :Bool
    var barberChangeTime :Bool
    var offer :Bool
    var agree :Bool
    var barberNotShow :Bool
    var customerNotShow :Bool
    
    var discountValue :Int
    
    
    init?(
        requestID :String,
        customerID :String,
        customerName :String,
        customerToken :String,
        customerImageURL :String,
        barberID :String,
        barberName :String,
        barberToken :String,
        barberImageURL :String,
        barberShopName :String,
        requestTime :AnyObject,
        timeorder :AnyObject,
        customerComment :String,
        barberComment :String,
        
        customerAnswered :Bool,
        barberAnswered :Bool,
        complete :Bool,
        customerReviewed :Bool,
        barberReviewed :Bool,
        canceled :Bool,
        customerChangeTime :Bool,
        barberChangeTime :Bool,
        offer :Bool,
        agree :Bool,
        barberNotShow :Bool,
        customerNotShow :Bool,
        
        discountValue :Int
        ) {
        // The name must not be empty
        guard !requestID.isEmpty else {
            return nil
        }
        
        self.requestID = requestID
        self.customerID = customerID
        self.customerName = customerName
        self.customerToken = customerToken
        self.customerImageURL = customerImageURL
        self.barberID = barberID
        self.barberName = barberName
        self.barberToken = barberToken
        self.barberImageURL = barberImageURL
        self.barberShopName = barberShopName
        self.requestTime = requestTime
        self.timeorder = timeorder
        self.customerComment = customerComment
        self.barberComment = barberComment
        self.customerAnswered = customerAnswered
        self.barberAnswered = barberAnswered
        self.complete = complete
        self.customerReviewed = customerReviewed
        self.barberReviewed = barberReviewed
        self.canceled = canceled
        self.customerChangeTime = customerChangeTime
        self.barberChangeTime = barberChangeTime
        self.offer = offer
        self.agree = agree
        self.barberNotShow = barberNotShow
        self.customerNotShow = customerNotShow
        self.discountValue = discountValue
        
    }
    func getData ()->[String:AnyObject]{
        var newUser = [String:AnyObject]()
        
        
        newUser["requestID"] = self.requestID as AnyObject ?? 0.0 as AnyObject
        newUser["customerID"] = self.customerID as AnyObject ?? 0 as AnyObject
        newUser["customerName"] = self.customerName as AnyObject ?? 0.0 as AnyObject
        newUser["customerToken"] = self.customerToken as AnyObject ?? 0 as AnyObject
        newUser["customerImageURL"] = self.customerImageURL as AnyObject ?? "" as AnyObject
        newUser["barberID"] = self.barberID as AnyObject ?? "" as AnyObject
        newUser["barberName"] = self.barberName as AnyObject ?? "" as AnyObject
        newUser["barberToken"] = self.barberToken as AnyObject ?? false as AnyObject
        newUser["barberImageURL"] = self.barberImageURL as AnyObject ?? 0 as AnyObject
        newUser["barberShopName"] = self.barberShopName as AnyObject ?? "" as AnyObject
        newUser["requestTime"] = self.requestTime as AnyObject ?? 0.0 as AnyObject
        newUser["timeorder"] = self.timeorder as AnyObject ?? 0 as AnyObject
        newUser["customerComment"] = self.customerComment as AnyObject ?? "" as AnyObject
        newUser["barberComment"] = self.barberComment as AnyObject ?? "" as AnyObject
        newUser["customerAnswered"] = self.customerAnswered as AnyObject ?? 0 as AnyObject
        newUser["barberAnswered"] = self.barberAnswered as AnyObject ?? "" as AnyObject
        newUser["canceled"] = self.canceled as AnyObject ?? "" as AnyObject
        newUser["customerChangeTime"] = self.customerChangeTime as AnyObject ?? 0.0 as AnyObject
        newUser["barberChangeTime"] = self.barberChangeTime as AnyObject ?? 0.0 as AnyObject
        
        newUser["offer"] = self.offer as AnyObject ?? 0 as AnyObject
        newUser["agree"] = self.agree as AnyObject ?? "" as AnyObject
        newUser["barberNotShow"] = self.barberNotShow as AnyObject ?? "" as AnyObject
        
        return newUser
    }
    
}
