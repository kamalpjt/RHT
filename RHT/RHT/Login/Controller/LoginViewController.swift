//
//  LoginViewController.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import GoogleSignIn
import ApiAI


class LoginViewController: BaseViewController,UITextFieldDelegate,GIDSignInDelegate,GIDSignInUIDelegate {
    
    @IBOutlet weak var vFacebook: UIView!
    @IBOutlet weak var vGoogle: UIView!
    @IBOutlet weak var butLogin: UIButton!
    @IBOutlet weak var butForgotPassowrd: UIButton!
    @IBOutlet weak var txtPassowrd: UITextField!
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var vEmail: UIView!
    @IBOutlet weak var vShadowView: UIView!
    @IBOutlet weak var vRegisterTap: UIView!
    @IBOutlet weak var vLogin: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        txtPassowrd.text = "12345678"
        txtemail.text = "rht@gmail.com"
        SetUpView()
        SetTextFieldImage()
        CloseKeyboard(bool: true);
        //        let tapgoogle = UITapGestureRecognizer(target: self, action:#selector(GoogleTap))
        //        tapgoogle.numberOfTapsRequired=1;
        //        vGoogle.addGestureRecognizer(tapgoogle)
        //        let tapfacebook = UITapGestureRecognizer(target: self, action:#selector(FacebookTap))
        //        tapfacebook.numberOfTapsRequired=1;
        //        vFacebook.addGestureRecognizer(tapfacebook)
        
        // Do any additional setup after loading the view.
        
        
//        HttpRequestMethod.sharedInstance.getMethod(url: "https://api.letsbuildthatapp.com/jsondecodable/courses_snake_case", responseBlcok: { response in
//
//        })
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true;
        AddKeyboardObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=false;
        RemoveKeyboardObserver()
    }
    func SetUpView() -> Void {
        
        SetBackGroundColor(color: AppConstant.sharedInstance.backGroundColor)
        ShareData.sharedInstance.SetCornerRadius(view: vLogin, radius: 15);
        ShareData.sharedInstance.SetCornerRadius(view: vShadowView, radius: 15)
        ShareData.sharedInstance.SetCornerRadiusButton(view: butLogin, radius: 10)
        ShareData.sharedInstance.DrawBorder(view: vEmail, color: AppConstant.sharedInstance.viewEmailBoder);
        let borderWidth: CGFloat = 1
        vEmail.frame = vEmail.frame.insetBy(dx: -borderWidth, dy: -borderWidth)
        vEmail.layer.borderColor =  AppConstant.sharedInstance.viewEmailBoder.cgColor;
        vEmail.layer.borderWidth = borderWidth
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
        
        //        let passowordeye = UIImageView(frame: CGRect(x: 0, y: -15, width: 20, height: 20))
        //        passowordeye.contentMode = UIViewContentMode.scaleAspectFit;
        //        passowordeye.image = UIImage(named: "eye")
        //        let tapfacebook = UITapGestureRecognizer(target: self, action:#selector(eyeButtonTap))
        //        tapfacebook.numberOfTapsRequired=1;
        //        txtPassowrd.rightView?.addGestureRecognizer(tapfacebook)
        
        let passworbutton = UIButton.init(type: UIButtonType.custom)
        passworbutton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        passworbutton.setImage(UIImage(named: "eye"), for: UIControlState.normal)
        passworbutton.addTarget(self, action: #selector(self.eyeButtonTap), for: UIControlEvents.touchUpInside)
        
        
        txtPassowrd.rightView = passworbutton
        txtPassowrd.rightViewMode = UITextFieldViewMode.always
        
        butForgotPassowrd.setAttributedTitle(ShareData.sharedInstance.UnderLineText(text: "Forgot Passowrd?"), for: UIControlState.normal)
        
    }
    @objc func FacebookTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile,.email], viewController: self) { (loginResult) in
            
            switch loginResult {
            case .failed(let Error):
                print(Error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print(grantedPermissions)
                print(declinedPermissions)
                print(accessToken)
                self.getFbId()
                
            }
        }
    }
    func getFbId(){
        if(FBSDKAccessToken.current() != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name , first_name, last_name , email,picture.type(large)"]).start(completionHandler: { (connection, result, error) in
                guard let Info = result as? [String: Any] else { return }
                
                let emailUrl = Info.values
                
                // let emails = ((Info["email"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String
                print(emailUrl)
                
                if let imageURL = ((Info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String {
                    //Download image from imageURL
                }
                if(error == nil){
                    print("result")
                }
            })
        }
    }
    @objc func GoogleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    @objc func eyeButtonTap(sender: UIButton!) {
        txtPassowrd.isSecureTextEntry = txtPassowrd.isSecureTextEntry == true ? false:true
    }
    func Vaildation() -> Bool{
        
        if txtemail.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtemail.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title:StringConstant.instance.ALERTTITLE , message: StringConstant.instance.ENTEREMAIL, viewController: self)
            return false
        }else if !ShareData.sharedInstance.emailValidation(emailText: txtemail.text!) {
            txtemail.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title:StringConstant.instance.ALERTTITLE , message: StringConstant.instance.VALIDMAIL, viewController: self)
            return false
        }else if txtPassowrd.text?.trimmingCharacters(in: .whitespacesAndNewlines).count == 0 {
            txtPassowrd.becomeFirstResponder()
            SharedAlert.instance.ShowAlert(title:StringConstant.instance.ALERTTITLE , message: StringConstant.instance.ENTERPASSOWRD, viewController: self)
            return false
        }
        return true
    }
    @IBAction func LoginAction(_ sender: Any) {
        if(Vaildation()){
            //        HttpRequestMethod.sharedInstance.getMethod(url: "https://api.letsbuildthatapp.com/jsondecodable/courses_snake_case", responseBlcok: { response in
            //
            //        })
            let params:[String:String] = ["name":txtemail.text!,"password":txtPassowrd.text!]
            
            LoginParsing.instance.getLoginDetail(url: "/login", param: params, resposneBlock: { response , statuscode in
                if(statuscode == 200){
                      self.SetResidemenu()
                }
//                let res = response as! UserDetailModel
//                let dfdf = res.user.email
            })
          
        }
    }
    @IBAction func RegisterButton(_ sender: Any) {
        var storyboardLogin:UIStoryboard;
        if ShareData.isIpad()
        {
            storyboardLogin = UIStoryboard(name: "Loginipad", bundle: nil)
        }else{
            storyboardLogin = UIStoryboard(name: "Login", bundle: nil)
        }
        
        let VC1 = storyboardLogin.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        self.navigationController?.pushViewController(VC1, animated: true)
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
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
        } else {
            
            // Perform any operations on signed in user here.
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            // ...
        }
    }
    func sign(_ signIn: GIDSignIn!,dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
