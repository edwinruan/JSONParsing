//
//  JPDetailViewController.swift
//  JSONParsing
//
//  Created by Rush01 on 12/12/18.
//  Copyright © 2018 Rush01. All rights reserved.
//

import UIKit

class JPDetailViewController: UIViewController {
    // Object Summary
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var colorLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    //Optional fields
    @IBOutlet var doorsLabel: UILabel?
    @IBOutlet var priceLabel: UILabel?
    @IBOutlet var milageLabel: UILabel?
    @IBOutlet var purchaseDateLabel: UILabel?
    @IBOutlet var ageLabel: UILabel?
    @IBOutlet var favoriteToyLabel: UILabel?
    @IBOutlet var profileImageView: UIImageView!
    
    // Constraints
    @IBOutlet var profileImageWidthConstraint: NSLayoutConstraint!
    @IBOutlet var profileImageHeightConstraint: NSLayoutConstraint!
    
    var defaultImageWidth: CGFloat = 100
    var defaultImageHeight: CGFloat = 100
    var objectModel: JPObjectModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Object Summary"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    

    
    func configureView() {
        if let object = objectModel {
            let subTypeValue = object.name ?? " "
            nameLabel.text = "Subtype: " + subTypeValue
            if let detail = object.objectDetail {
                hiddenLabelIfNoData()
                titleLabel.text = detail.objectSummary?.name
                
                let typeValue = detail.objectSummary?.type ?? " "
                typeLabel.text = "Type: " + typeValue
                
                let colorValue = detail.objectSummary?.color ?? " "
                colorLabel.text = "Color: " + colorValue
                descriptionLabel.text = detail.objectSummary?.description
                
                // Optional fields
                let doorValue = detail.doors ?? " "
                doorsLabel?.text = "Doors: " + doorValue
                
                let priceValue = detail.price ?? " "
                priceLabel?.text = "Price: " + priceValue
                
                
                let milageValue = detail.milage ?? " "
                milageLabel?.text = "Milage: " + milageValue
                
                let purchaseDateValue = detail.purchaseDate ?? " "
                purchaseDateLabel?.text = "Purchased: " + purchaseDateValue
                
                let ageValue = detail.age ?? " "
                ageLabel?.text = "Age: " + ageValue
                
                let favoriteToyValue = detail.favoriteToy ?? " "
                favoriteToyLabel?.text = "Toy: " + favoriteToyValue
                
                profileImageView.image = UIImage(named: "defaultImage")
                profileImageHeightConstraint.constant = defaultImageWidth
                profileImageHeightConstraint.constant = defaultImageHeight
                
                // resize image based on json
                //            if let widthStr = detail.image?.width {
                //                let widthInt = widthStr.replacingOccurrences(of: "px", with: "")
                //                if let value = Double(widthInt) {
                //                    profileImageWidthConstraint.constant = CGFloat(value)
                //                }
                //            }
                //            if let heightStr = detail.image?.height {
                //                let heightInt = heightStr.replacingOccurrences(of: "px", with: "")
                //                if let value = Double(heightInt) {
                //                    profileImageHeightConstraint.constant = CGFloat(value)
                //                }
                //            }
                
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
    }
    
    // hide label if data is nil
    func hiddenLabelIfNoData() {
        if let detail = self.objectModel?.objectDetail {
            doorsLabel?.isHidden = detail.doors == nil ? true : false
            priceLabel?.isHidden = detail.price == nil ? true : false
            milageLabel?.isHidden = detail.milage == nil ? true : false
            purchaseDateLabel?.isHidden = detail.purchaseDate == nil ? true : false
            ageLabel?.isHidden = detail.age == nil ? true : false
            favoriteToyLabel?.isHidden = detail.favoriteToy == nil ? true : false
        }
    }

}
