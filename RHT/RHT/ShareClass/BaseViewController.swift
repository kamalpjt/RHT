//
//  BaseViewController.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import Reachability
class BaseViewController: UIViewController {

   public var basescrollView:UIScrollView?
   let reachability = Reachability()
    override func viewDidLoad() {
        super.viewDidLoad()

       
        //SetBackGroundColor()
        // Do any additional setup after loading the view.
        if  reachability?.connection == Reachability.Connection.none{
             SharedAlert.instance.OffLineAlert(viewController: self)
        }
        
    }
    func checkInternetIsAvailable() -> Bool{
        if  reachability?.connection != Reachability.Connection.none{
            return true
        }else{
            SharedAlert.instance.OffLineAlert(viewController: self)
            return false
        }
    }
    override func viewWillAppear(_ animated: Bool) {
         AddKeyboardObserver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        RemoveKeyboardObserver()
        SVProgressHUD.dismiss()
    }
    
    func  SetBackGroundColor(color: UIColor) -> Void {
        view.backgroundColor = color;
    }
    
    func RemoveKeyboardObserver() -> Void {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    }
    func AddKeyboardObserver() -> Void {
       
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        if(basescrollView != nil){
            let keyboardInfoFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let windowFrame  =  (UIApplication.shared.keyWindow!.convert(self.view.frame, from: self.view))
            let keyboardFrame = CGRect(origin: windowFrame.origin, size: (keyboardInfoFrame?.size)!)
            let coveredFrame = UIApplication.shared.keyWindow!.convert(keyboardFrame, to: self.view)
            let contentInsets = UIEdgeInsetsMake(0, 0, (coveredFrame.size.height)+20, 0.0)
            self.basescrollView? .contentInset = contentInsets;
            self.basescrollView?.scrollIndicatorInsets = contentInsets;
            self.basescrollView?.contentSize = CGSize(width: (self.basescrollView?.contentSize.width)!, height: (self.basescrollView?.contentSize.height)!)

        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        print("keyboardWillHide")
         if(basescrollView != nil){
            self.basescrollView? .contentInset = UIEdgeInsets.zero
            self.basescrollView?.scrollIndicatorInsets =  UIEdgeInsets.zero;
        }
    }
    func CloseKeyboard(bool:Bool) -> Void {
        if(bool){
           // view.endEditing(true);
            let tap = UITapGestureRecognizer(target: self, action:#selector(handleTap))
            self.view.addGestureRecognizer(tap)
        }
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func menuButton() -> UIBarButtonItem{
        let menuButton = UIButton.init(type: UIButtonType.custom)
        menuButton.setImage(UIImage.init(named: "menu"), for: UIControlState.normal)
        menuButton.addTarget(self, action:#selector(presentLeftMenuViewController(_:)), for: UIControlEvents.touchUpInside)
        menuButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        menuButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        menuButton.contentMode = UIViewContentMode.right
        let barbutton = UIBarButtonItem.init(customView: menuButton)
        return barbutton
    }
    func SetResidemenu() -> Void {
        let storyboardLogin:UIStoryboard;
            storyboardLogin = UIStoryboard(name: "Login", bundle: nil)
//        if !ShareData.isIpad() {
//        
//        }else{
//            storyboardLogin = UIStoryboard(name: "Loginipad", bundle: nil)
//        }
        
        let VC1 = storyboardLogin.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let navi = UINavigationController.init(rootViewController: VC1)
        let  leftmenu = storyboardLogin.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
         let navi2 = UINavigationController.init(rootViewController: leftmenu)
        let resdidemenu = RESideMenu.init(contentViewController: navi, leftMenuViewController: navi2, rightMenuViewController: nil)
        UIApplication.shared.keyWindow?.rootViewController  = resdidemenu;
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
