//
//  MasterDetailDelegate.swift
//  RHT
//
//  Created by kamal on 20/05/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class MasterDetailDelegate: NSObject,UITableViewDelegate {

   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
         let  num = ShareData.sharedInstance.GetStringCGSize(stringValue: "Sachin Ramesh Tendulkar is a former Indian international cricketer and a former captain of the Indian national team, regarded as one of the greatest batsmen of all time. He is the highest run scorer of all time in International cricket.", font: UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: UIFont.Weight.regular))
        return 285+num.height-15
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
