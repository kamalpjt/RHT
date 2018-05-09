//
//  RegisterViewController.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController ,UITextFieldDelegate{
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPhoneNumber: CustomTextField!
    @IBOutlet weak var txtConfirmPassowrd: CustomTextField!
    @IBOutlet weak var txtPassowrd: CustomTextField!
    @IBOutlet weak var txtLastName: CustomTextField!
    @IBOutlet weak var txtFirstName: CustomTextField!
    @IBOutlet weak var butRegister: UIButton!
    @IBOutlet weak var vShadowView: UIView!
    @IBOutlet weak var vRegister: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        SetBackGroundColor(color: AppConstant.sharedInstance.backGroundColor)
        //ShareData.sharedInstance.SetCornerRadiusButton(view: butRegister, radius: 8);
        ShareData.sharedInstance.SetCornerRadius(view: vRegister, radius: 15);
        ShareData.sharedInstance.SetCornerRadius(view: vShadowView, radius: 15)
        ShareData.sharedInstance.SetCornerRadiusButton(view: butRegister, radius: 10)
        vShadowView.bringSubview(toFront: vRegister)
        txtEmail.delegate = self ;
        txtFirstName.delegate = self ;
        txtLastName.delegate = self;
        txtPassowrd.delegate = self
        txtConfirmPassowrd.delegate = self;
        txtPhoneNumber.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        print("Button tapped")
    }
    @IBAction func RegisterAction(_ sender: Any) {
        SetResidemenu()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case txtFirstName:
            txtLastName.becomeFirstResponder()
            break;
        case txtLastName:
            txtEmail.becomeFirstResponder()
            break;
        case txtEmail:
            txtPassowrd.becomeFirstResponder()
            break;
        case txtPassowrd:
            txtConfirmPassowrd.becomeFirstResponder()
            break;
        case txtConfirmPassowrd:
            txtPhoneNumber.becomeFirstResponder()
            break;
        case txtPhoneNumber:
            self.view.endEditing(true)
            break;
        default:
            self.view.endEditing(true)
        }
        return true;
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
