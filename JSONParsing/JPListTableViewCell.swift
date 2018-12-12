//
//  JPListTableViewCell.swift
//  JSONParsing
//
//  Created by Rush01 on 12/12/18.
//  Copyright © 2018 Rush01. All rights reserved.
//

import UIKit

class JPListTableViewCell: UITableViewCell {
    
    // Object Summary
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    
    var defaultImageWidth: CGFloat = 50
    var defaultImageHeight: CGFloat = 50
    var objectDetail: JPObjectDetail?
    
    func configure(_ object: JPObjectModel) {
        nameLabel?.text =  object.name
        if let detail = object.objectDetail {
            self.objectDetail = detail
            typeLabel?.text = detail.objectSummary?.type
            colorLabel?.text = detail.objectSummary?.color
            profileImageView.image = UIImage(named: "defaultImage")
            if let urlString = detail.image?.url, let url = URL(string: urlString) {
                JPHelper.getData(from: url) { (data, reponse, error) in
                    guard let data = data, error == nil else { return }
                    print("Download Completed")
                    DispatchQueue.main.async {
                        self.profileImageView.contentMode = .scaleAspectFill
                        self.profileImageView.image = UIImage(data: data)
                    }
                }
            }
        }
}
