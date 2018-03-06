//
//  AdsView.swift
//  AvitoProjectTest
//
//  Created by Zakaria elmouatassim on 05/03/2018.
//  Copyright © 2018 Zakaria elmouatassim. All rights reserved.
//

import Foundation
class AdsView : NSObject{
    
    var adsId : NSInteger?
    var subject : String?
    var name : String?
    var bodyDesc : String?
    var price : NSInteger?
    var imagePath : String?
    var  date : String?

    init(adsId: NSInteger?, subject: String?, name: String? ,bodyDesc: String?, price: NSInteger?, imagePath: String?  , date : String?) {
        self.adsId = adsId
        self.subject = subject
        self.name = name
        self.bodyDesc = bodyDesc
        self.price = price
        self.imagePath = imagePath
        self.date = date
    }


    
    
    
}
