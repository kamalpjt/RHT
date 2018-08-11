//
//  ChangePasswordController.swift
//  RHT
//
//  Created by kamal on 24/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ChangePasswordController: BaseViewController,UITextFieldDelegate {
    @IBOutlet weak var txtOldPassowrd: CustomTextField!
    
    @IBOutlet weak var btnSumbit: UIButton!
    @IBOutlet weak var svScrollView: UIScrollView!
    @IBOutlet weak var txtConfirmPassowrd: CustomTextField!
    @IBOutlet weak var txtNewPassowrd: CustomTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtNewPassowrd.delegate = self
        txtOldPassowrd.delegate = self
        txtConfirmPassowrd.delegate = self
        self.basescrollView = svScrollView
        btnSumbit.layer.cornerRadius = 5
        btnSumbit.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtOldPassowrd {
            txtNewPassowrd.becomeFirstResponder()
        }else if textField == txtNewPassowrd {
            txtConfirmPassowrd.becomeFirstResponder()
        }else if textField == txtConfirmPassowrd {
            view.endEditing(true)
        }
        return true
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
        
        if Vaildation() {
            
            if(checkInternetIsAvailable()){
                let param:[String:Any] = ["id":UserDetail.Instance.id!,
                                          "userid":UserDetail.Instance.userid!,
                                          "email":UserDetail.Instance.email!,
                                          "oldpassword":txtOldPassowrd.text!,
                                          "newpassword":txtNewPassowrd.text!,
                                          "user_type":UserDetail.Instance.user_type!,
                                          "sessionid":"1",
                                          "ostype":"ios",
                                          "appversion":(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!,
                                          "devicetype":"mobile",
                                          "osversion":UIDevice.current.systemVersion]
                LoginParsing.instance.changePassowrd(url: "/changepassword",withLoader:true, param: param, resposneBlock: { response , statuscode in
                    if(statuscode == 200){
                        let model = response as! CommentPostModel
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE , message: model.response.msg!, viewController: self)
                    }
                })
            }
            
        }
    }
    
    
}
