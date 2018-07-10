//
//  AppDelegate.swift
//  RHT
//
//  Created by vinoth on 29/03/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import GoogleSignIn;
import Foundation
import Alamofire
import ApiAI
import SVProgressHUD
import AWSS3
import Photos
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window?.rootViewController = showLaunchScreen()
        GIDSignIn.sharedInstance().clientID = AppConstant.sharedInstance.gooleplusid;
        setNavigationBar()
        //Set enviroment
        AppConfig.sharedInstance.setEnviroment(eBuildEnvironments: eBuildEnvironment.eDev)
        SVProgressHUD.setBackgroundColor(AppConstant.sharedInstance.backGroundColor)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        
        //SetChat Bot
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken =  AppConfig.sharedInstance.dialogflowApi!
        let apiai = ApiAI.shared()
        apiai?.configuration = configuration
        
        //ConfigAWS
        ConfigAws()
        CheckPhotoAutorizsation()
        createPdfFolder()
        self.window?.makeKeyAndVisible()
         
        return true
    }
    func ConfigAws()
    {
        let myIdentityPoolId = AppConfig.sharedInstance.AWSSID!
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.APSoutheast1,
                                                                identityPoolId:myIdentityPoolId)
        let configuration = AWSServiceConfiguration(region:.APSoutheast1, credentialsProvider:credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        //AWSDDLog.allLoggers.
    }
    func showLaunchScreen() -> UIViewController {
        var storyboard:UIStoryboard ;
        if ShareData.isIpad(){
             storyboard = UIStoryboard.init(name: "Loginipad", bundle: Bundle.main)
        }else{
            storyboard = UIStoryboard.init(name: "Login", bundle: Bundle.main)
        }
    
        let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
         let navController = UINavigationController(rootViewController: rootViewController)
        return navController;
    }
    func setNavigationBar() -> Void {
        UINavigationBar.appearance().tintColor = UIColor.white;
        UINavigationBar.appearance().backgroundColor = AppConstant.sharedInstance.backGroundColor;
        UINavigationBar.appearance().barTintColor = AppConstant.sharedInstance.backGroundColor;
        UINavigationBar.appearance().isTranslucent = false;
        let attributes = [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 17), NSAttributedStringKey.foregroundColor : UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = attributes;
    }
    func CheckPhotoAutorizsation() -> Void {
         PHPhotoLibrary.requestAuthorization { (status) in
        }
    }
    private func createPdfFolder() {
        // path to documents directory
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        if let documentDirectoryPath = documentDirectoryPath {
            // create the custom folder path
            let imagesDirectoryPath = documentDirectoryPath.appending(AppConstant.sharedInstance.LOCALPDFFOLDER)
            let fileManager = FileManager.default
            if !fileManager.fileExists(atPath: imagesDirectoryPath) {
                do {
                    try fileManager.createDirectory(atPath: imagesDirectoryPath,
                                                    withIntermediateDirectories: false,
                                                    attributes: nil)
                } catch {
                    print("Error creating images folder in documents dir: \(error)")
                }
            }else{
                 print("FilePath:" + imagesDirectoryPath)
            }
           
        }
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url, sourceApplication:sourceApplication , annotation: annotation)
    }
    
}

