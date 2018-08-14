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
        
        if txtPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtPhoneNumber.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title:StringConstant.instance.ALERTTITLE , message: StringConstant.instance.ENTERPHONENUMBER, viewController: self)
        }else{
            if(checkInternetIsAvailable()){
                let countryCode =  txtPhoneNumber.getCountryPhoneCode() ?? ""
                let getPhonenumber = txtPhoneNumber.getRawPhoneNumber() ?? ""
                let param:[String:Any] = ["id":UserDetail.Instance.id!,
                                          "user_type":UserDetail.Instance.user_type!,
                                          "phone":(countryCode.replacingOccurrences(of: "+", with: "")) + getPhonenumber,
                                          "sessionid":"1",
                                          "ostype":"ios",
                                          "appversion":(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!,
                                          "devicetype":"mobile",
                                          "osversion":UIDevice.current.systemVersion]
                LoginParsing.instance.getVerificationCode(url: "/getverificationcode",withLoader:true, param: param, resposneBlock: { response , statuscode in
                    if(statuscode == 200){
                        let model = response as! ActivateModel
                        if model.response.sentotp == 1 {
                            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE , message:StringConstant.instance.OTPSENTSUCCESSFULLY + " to \(String(describing: model.response.phone))"  , viewController: self)
                        }
                        
                    }
                })
            }
        }
    }
    func didChangeVerificationCode() {
        if vOTP.hasValidCode()  {
            debugPrint("true")
            view.endEditing(true)
            if(checkInternetIsAvailable()){
                //let countryCode =  txtPhoneNumber.getCountryPhoneCode() ?? ""
               // let getPhonenumber = txtPhoneNumber.getRawPhoneNumber() ?? ""
                let param:[String:Any] = ["id":UserDetail.Instance.id!,
                                          "user_type":UserDetail.Instance.user_type!,
                                          "phone":UserDetail.Instance.phone ?? "",
                                          "verificationcode":vOTP.getVerificationCode(),
                                          "sessionid":"1",
                                          "ostype":"ios",
                                          "appversion":(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!,
                                          "devicetype":"mobile",
                                          "osversion":UIDevice.current.systemVersion]
                LoginParsing.instance.verifyOTP(url: "/verifyuserbycode",withLoader:true, param: param, resposneBlock: { response , statuscode in
                    if(statuscode == 200){
                        let model = response as! VerifyOTPModel
                        if model.response.verifysucess == 1 {
//                            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE , message:StringConstant.instance.OTPSENTSUCCESSFULLY + " to \(String(describing: model.response.phone))"  , viewController: self)
                        }
                        
                    }
                })
            }
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
