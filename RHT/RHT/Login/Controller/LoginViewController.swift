//
//  LoginViewController.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController,UITextFieldDelegate {
    
    @IBOutlet weak var butForgotPassowrd: UIButton!
    @IBOutlet weak var txtPassowrd: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vShadowView: UIView!
    @IBOutlet weak var vRegisterTap: UIView!
    @IBOutlet weak var vLogin: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUpView()
        SetTextFieldImage()
        CloseKeyboard(bool: true);
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         self.navigationController?.navigationBar.isHidden=true;
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=false;
    }
    func SetUpView() -> Void {
        
        SetBackGroundColor(color: AppConstant.sharedInstance.backGroundColor)
        ShareData.sharedInstance.SetCornerRadius(view: vLogin, radius: 15);
        ShareData.sharedInstance.SetCornerRadius(view: vShadowView, radius: 15)
        ShareData.sharedInstance.DrawBorder(view: vEmail, color: AppConstant.sharedInstance.viewEmailBoder);
        if ShareData.isIPhone5() {
            ShareData.sharedInstance.SetCornerRadius(view: vEmail, radius: 18)
        }else if ShareData.isIPhone6(){
           ShareData.sharedInstance.SetCornerRadius(view: vEmail, radius:22)
        }else if ShareData.isIPhone6Plus() {
            ShareData.sharedInstance.SetCornerRadius(view: vEmail, radius: 25)
        } else if ShareData.isIPhoneX() {
            ShareData.sharedInstance.SetCornerRadius(view: vEmail, radius: 28)
        }else if ShareData.isIpad(){
            ShareData.sharedInstance.SetCornerRadius(view: vEmail, radius: 35)
        }
          vShadowView.bringSubview(toFront: vLogin)
    }
    
    func SetTextFieldImage() -> Void {
        txtPassowrd.delegate = self;
        txtemail.delegate = self;
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let image = UIImage(named: "Email")
        imageView.image = image
        txtemail.rightView = imageView
        txtemail.rightViewMode = UITextFieldViewMode.always
        
        let passowordimage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        passowordimage.image = UIImage(named: "Email")
        txtPassowrd.leftView = passowordimage
        txtPassowrd.leftViewMode = UITextFieldViewMode.always
        
        let passowordeye = UIImageView(frame: CGRect(x: 0, y: -15, width: 20, height: 20))
        passowordeye.contentMode = UIViewContentMode.scaleAspectFit;
        passowordeye.image = UIImage(named: "eye")
        txtPassowrd.rightView = passowordeye
        txtPassowrd.rightViewMode = UITextFieldViewMode.always
      
        butForgotPassowrd.setAttributedTitle(ShareData.sharedInstance.UnderLineText(text: "Forgot Passowrd?"), for: UIControlState.normal)
        
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        let storyboardLogin = UIStoryboard(name: "Login", bundle: nil)
        let VC1 = storyboardLogin.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(VC1, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        return true;
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtemail {
            txtPassowrd.becomeFirstResponder();
        }else if textField == txtPassowrd {
            view.endEditing(true);
        }
        return true
    }
    

   

}
