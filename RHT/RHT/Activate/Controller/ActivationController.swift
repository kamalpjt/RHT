//
//  ActivationController.swift
//  RHT
//
//  Created by kamal on 11/08/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import CTKFlagPhoneNumber
import KWVerificationCodeView
class ActivationController: BaseViewController,KWVerificationCodeViewDelegate {
    
    @IBOutlet weak var vOTP: KWVerificationCodeView!
    @IBOutlet weak var txtPhoneNumber: CTKFlagPhoneNumberTextField!
    @IBOutlet weak var btnPin: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtPhoneNumber.setFlag(with: "SG")
        vOTP.delegate = self
        btnPin.layer.cornerRadius = 5
        btnPin.layer.masksToBounds = true
        txtPhoneNumber.parentViewController = self
        CloseKeyboard(bool: true)
        basescrollView = self.scrollView
        // Do any additional setup after loading the view.
    }

    @IBAction func BtnPinAction(_ sender: Any) {
        
    }
    func didChangeVerificationCode() {
        if vOTP.hasValidCode()  {
            debugPrint("true")
            view.endEditing(true)
        }else{
             debugPrint("false")
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
