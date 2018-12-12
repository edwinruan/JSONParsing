//
//  JPListViewController.swift
//  JSONParsing
//
//  Created by Rush01 on 12/11/18.
//  Copyright © 2018 Rush01. All rights reserved.
//

import UIKit

class JPListViewController: UIViewController {
    var objectArray = [JPObjectModel]()
    
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Object List"
        tableView.register(UINib(nibName: "JPListTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "JPListTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        readJsonFile()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // read json file from bundle
    func readJsonFile() {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe)
                if let dict = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                    objectArray.removeAll()
                    for (key, value) in dict {
                        let jpObject = JPObjectModel(name: key, objectDict: value)
                        objectArray.append(jpObject)
                    }
                
                }
            } catch {
                print("error")
                // handle error
            }
        }
    }
    

}

extension JPListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "JPListTableViewCell", for: indexPath) as? JPListTableViewCell {
            cell.configure(objectArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

extension JPListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
       let vc = self.storyboard?.instantiateViewController(withIdentifier: "JPDetailViewController") as! JPDetailViewController
        vc.objectModel = objectArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

