//
//  JPObjectModel.swift
//  JSONParsing
//
//  Created by Rush01 on 12/11/18.
//  Copyright © 2018 Rush01. All rights reserved.
//

import UIKit

// Object Model Class
class JPObjectModel {
    var name: String?
    var objectDetail: JPObjectDetail?

    init() {
    }
    
    init(name: String?, objectDict: AnyObject) {
        if let name = name {
            self.name = name
        }
        if let objectDict = objectDict as? [String: AnyObject] {
            self.objectDetail = JPObjectDetail(objectDict)
        }
    }
}

// Object Detail
class JPObjectDetail {
    var objectSummary: JPObjectSummary?
    // car
    var doors: String?
    var price: String?
    var milage: String?
    
    // computer
    var purchaseDate: String?
    
    // animal
    var age: String?
    var favoriteToy: String?
    var image: JPImageObject?
    
    init() {}
    
    init(_ dict: [String: AnyObject]) {
        if let summaryDict = dict["object_summary"] as? [String: AnyObject] {
            self.objectSummary = JPObjectSummary(summaryDict)
        }
        self.doors = dict["doors"] as? String
        self.price = dict["price"] as? String
        self.milage = dict["milage"] as? String
        self.purchaseDate = dict["purchase_date"] as? String
        self.age = dict["age"] as? String
        self.favoriteToy = dict["favorite_toy"] as? String
        if let imageDict = dict["image"] as? [String: AnyObject] {
             self.image = JPImageObject(imageDict)
        }
    }
}

// ObjectSummary
class JPObjectSummary {
    var type: String?
    var name: String?
    var color: String?
    var description: String?
    
    init() {
    }
    
    init(_ dict: [String: AnyObject]) {
        self.type = dict["type"] as? String
        self.name = dict["name"] as? String
        self.color = dict["color"] as? String
        self.description = dict["description"] as? String
    }
}

// Image Object
class JPImageObject {
    var url: String?
    var width: String?
    var height: String?
    
    init() {
    }
    
    init(_ dict: [String: AnyObject]) {
        self.url = dict["url"] as? String
        self.width = dict["width"] as? String
        self.height = dict["height"] as? String
    }
}
