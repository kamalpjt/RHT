//
//  SharedAlert.swift
//  RHT
//
//  Created by kamal on 01/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class SharedAlert:UIAlertController {
    static let instance = SharedAlert()
    
    func ShowAlert(title:String,message:String,viewController:UIViewController) -> Void{
       let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstant.instance.OK, style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    func OffLineAlert(viewController:UIViewController) -> Void{
        let alert = UIAlertController.init(title: "Messasge", message: StringConstant.instance.OFFLINEMESSAGE, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: StringConstant.instance.OK, style: UIAlertActionStyle.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
