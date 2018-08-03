//
//  RegisterViewController.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import CTKFlagPhoneNumber
class RegisterViewController: BaseViewController ,UITextFieldDelegate{
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtEmail: CustomTextField!
    @IBOutlet weak var txtPhoneNumber: CTKFlagPhoneNumberTextField!
    @IBOutlet weak var txtConfirmPassowrd: CustomTextField!
    @IBOutlet weak var txtPassowrd: CustomTextField!
    @IBOutlet weak var txtLastName: CustomTextField!
    @IBOutlet weak var txtFirstName: CustomTextField!
    @IBOutlet weak var butRegister: UIButton!
    @IBOutlet weak var vShadowView: UIView!
    @IBOutlet weak var vRegister: UIView!
    //MARK:- ViewcontrollerLifeCycle
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
        //txtPhoneNumber.delegate = self;
        CloseKeyboard(bool: true)
        // Do any additional setup after loading the view.
         txtPhoneNumber.setFlag(with: "SG")
        let items = [
            UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save, target: self, action: nil),
            UIBarButtonItem(title: "Item 1", style: .plain, target: self, action: nil),
            UIBarButtonItem(title: "Item 2", style: .plain, target: self, action: nil)
        ]
       // txtPhoneNumber.textFieldInputAccessoryView = getCustomTextFieldInputAccessoryView(with: items)
        txtPhoneNumber.parentViewController = self
        txtPhoneNumber.placeholder = "Phone Number"
        txtPhoneNumber.borderStyle = UITextBorderStyle.none
         basescrollView = self.scrollView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //  AddKeyboardObserver()
      
    }
    private func getCustomTextFieldInputAccessoryView(with items: [UIBarButtonItem]) -> UIToolbar {
        let toolbar: UIToolbar = UIToolbar()
        
        toolbar.barStyle = UIBarStyle.default
        toolbar.items = items
        toolbar.sizeToFit()
        
        return toolbar
    }
    func Vaildation() -> Bool{
        
        if txtFirstName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtFirstName.becomeFirstResponder()
            return false
        }else if txtLastName.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtLastName.becomeFirstResponder()
            return false
        } else if txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtEmail.becomeFirstResponder()
            return false
        }else if !ShareData.sharedInstance.emailValidation(emailText: txtEmail.text!) {
            txtEmail.becomeFirstResponder()
            return false
        }else if txtPassowrd.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtPassowrd.becomeFirstResponder()
            return false
        }else if txtConfirmPassowrd.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtConfirmPassowrd.becomeFirstResponder()
            return false
        }else if txtPassowrd.text != txtConfirmPassowrd.text {
            txtPassowrd.becomeFirstResponder()
            return false
        }else if txtPhoneNumber.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0{
            txtPhoneNumber.becomeFirstResponder()
            return false
        }
        return true
    }
    @IBAction func RegisterAction(_ sender: Any) {
        if(Vaildation()){
            let params:[String:String] = ["email":txtEmail.text!,"password":txtPassowrd.text!,
                                          "first_name":txtFirstName.text!,"last_name":txtLastName.text!,
                                          "phone":txtPhoneNumber.getRawPhoneNumber()!,"ostype":"ios",
                                          "appversion":(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!,
                                          "devicetype":"mobile",
                                          "osversion":UIDevice.current.systemVersion]
            LoginParsing.instance.getLoginDetail(url: "/signup",withLoader:true, param: params, resposneBlock: { response , statuscode in
                if(statuscode == 200){
                    let model = response as! UserDetailModel
                    do {
                        //https://www.raywenderlich.com/172145/encoding-decoding-and-serialization-in-swift-4
                        let jsonEncoder = JSONEncoder()
                        let jsonData = try jsonEncoder.encode(model)
                        let json = String(data: jsonData, encoding: String.Encoding.utf8)
                        print(json!)
                        let saveSuccessful: Bool = KeychainWrapper.standard.set(json!, forKey: AppConstant.sharedInstance.SAVELOGINDETAIL)
                        let retrievedString: String? = KeychainWrapper.standard.string(forKey: AppConstant.sharedInstance.SAVELOGINDETAIL)
                        let data = retrievedString?.data(using: .utf8)!
                        let value = try JSONDecoder().decode(UserDetailModel.self, from: data!)
                       // UserDetail.Instance.isStaff = value.response.user.isStaff!
                        UserDetail.Instance.email = value.response.user.email!
                        UserDetail.Instance.phone = value.response.user.phone!
                        UserDetail.Instance.name = value.response.user.name!
                        UserDetail.Instance.password = value.response.user.password!
                        UserDetail.Instance.user_type = value.response.user.user_type!
                        UserDetail.Instance.userid = value.response.user.userid!
                        UserDetail.Instance.id = value.response.user.id!
                        if(saveSuccessful){
                            self.SetResidemenu()
                        }
                        
                    } catch  let jsonerror{
                        print(jsonerror)
                    }
                }
            })
            
        }
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
