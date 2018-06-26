//
//  ChangePasswordController.swift
//  RHT
//
//  Created by kamal on 24/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChangePasswordController: UIViewController {
    @IBOutlet weak var txtOldPassowrd: CustomTextField!
    
    @IBOutlet weak var txtConfirmPassowrd: CustomTextField!
    @IBOutlet weak var txtNewPassowrd: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Vaildation() -> Bool{
        
        if txtOldPassowrd.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtOldPassowrd.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: StringConstant.instance.ENTEROLDPASSOWRD, viewController: self)
            return false
        }
        else if txtNewPassowrd.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtNewPassowrd.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: StringConstant.instance.ENTERNEWPASSOWRD, viewController: self)
            return false
            
        }else if txtConfirmPassowrd.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtConfirmPassowrd.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message:StringConstant.instance.ENTERCONFIRMPASSOWRD, viewController: self)
            
            return false
        }else if txtNewPassowrd.text != txtConfirmPassowrd.text {
            txtNewPassowrd.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: StringConstant.instance.PASSWORDMISMATCHED, viewController: self)
            return false
        }
        return true
    }
    
    @IBAction func SubmitAction(_ sender: Any) {
        
        var param:[String:Any] = ["email":UserDetail.Instance.email!,"userid":UserDetail.Instance.id!,
                                     "oldPassword":txtOldPassowrd.text!,"newPassword":txtOldPassowrd.text!]
        if Vaildation() {
            
        }
    }
    
    
}
