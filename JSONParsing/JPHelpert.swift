//
//  JPHelper.swift
//  JSONParsing
//
//  Created by Rush01 on 12/11/18.
//  Copyright © 2018 Rush01. All rights reserved.
//

import UIKit


class JPHelper {
    // get data from url in order to load web image url
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
}
