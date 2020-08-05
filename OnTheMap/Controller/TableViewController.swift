//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Amnah on 8/1/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
        
    var results: [StudentInformation]! {
        return StudentsInfromationModel.shared.results
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
     //1- Impelement number of rows method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    // 2- Implement the cell population method
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kTableViewCellID)!
        
        let uniqueStudentInfo = results[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = "\(uniqueStudentInfo.firstName) \(uniqueStudentInfo.lastName)"
        cell.detailTextLabel?.text = uniqueStudentInfo.mediaURL
        cell.imageView?.image = UIImage(systemName: "mappin")
        return cell
    }
    
    // 3- Implement the row selection method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let uniqueStudentInfo = results[(indexPath as NSIndexPath).row]
        
        if let url = URL(string: uniqueStudentInfo.mediaURL) {
            UIApplication.shared.open(url)
        }
        
    }
    

}
