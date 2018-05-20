//
//  MatterDetailDataSource.swift
//  RHT
//
//  Created by kamal on 5/18/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class MatterDetailDataSource: NSObject,UITableViewDataSource {
    
      private let cellIdentifier = "MatterDetailCell"
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MatterDetailCell
        cell.SetUpView()
        return cell
    }
    

}
