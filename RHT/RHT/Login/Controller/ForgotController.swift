//
//  ForgotController.swift
//  RHT
//
//  Created by kamal on 15/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ForgotController: UIViewController {

    @IBOutlet weak var txtEmail: CustomTextField!
    public var emailid:String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        if(emailid?.count)! > 0 {
             txtEmail.text =  emailid
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func Vaildation() -> Bool{
        
        if txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtEmail.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title:StringConstant.instance.ALERTTITLE , message: StringConstant.instance.ENTEREMAIL, viewController: self)
            return false
        }else if !ShareData.sharedInstance.emailValidation(emailText: txtEmail.text!) {
            txtEmail.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title:StringConstant.instance.ALERTTITLE , message: StringConstant.instance.VALIDMAIL, viewController: self)
            return false
        }
        return true
    }
   
    @IBAction func SubmitAction(_ sender: Any) {
        
        //var param:[String:Any] = ["":]
        if(Vaildation())
        {
            
        }
    }
    
   

}
