//
//  RegisterViewController.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class RegisterViewController: BaseViewController {

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
        vShadowView.bringSubview(toFront: vRegister)
        // Do any additional setup after loading the view.
    }

    @objc func buttonAction(_ sender:UIButton!)
    {
        print("Button tapped")
    }
    @IBAction func RegisterAction(_ sender: Any) {
      let storyboardLogin = UIStoryboard(name: "Login", bundle: nil)
      let VC1 = storyboardLogin.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//        self.navigationController?.pushViewController(VC1, animated: true)
        
        let navi = UINavigationController.init(rootViewController: VC1)
        
        
        let  leftmenu = storyboardLogin.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        
        let resdidemenu = RESideMenu.init(contentViewController: navi, leftMenuViewController: leftmenu, rightMenuViewController: nil)
        
        UIApplication.shared.keyWindow?.rootViewController  = resdidemenu;
        
        
        
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
