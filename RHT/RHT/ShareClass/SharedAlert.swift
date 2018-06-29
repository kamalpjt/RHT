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
    func MoveToSetting(viewController:UIViewController,message:String) -> Void{
        let alertController = UIAlertController (title: StringConstant.instance.ALERTTITLE, message:message, preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                   // print("Settings opened: \(success)") // Prints true
                })
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
       viewController.present(alertController, animated: true, completion: nil)
    }
}
