//
//  LoginParsing.swift
//  RHT
//
//  Created by kamal on 04/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
typealias parsedJsonData = (Any ,Int) -> Void
class LoginParsing {
    
    static let instance = LoginParsing()
    func getLoginDetail (url:String,withLoader:Bool,param:[String:String],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url,withLoader:withLoader, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(UserDetailModel.self, from: sucessresponse)
                 
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        
                        resposneBlock(login, statuscode)
                        
                    }else{
                         SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
    
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    func logOutApp (url:String,withLoader:Bool,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url,withLoader:withLoader, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(CommentPostModel.self, from: sucessresponse)
                    
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    func changePassowrd (url:String,withLoader:Bool,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url,withLoader:withLoader, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(CommentPostModel.self, from: sucessresponse)
                    
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    func forgotPassowrd (url:String,withLoader:Bool,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url,withLoader:withLoader, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(CommentPostModel.self, from: sucessresponse)
                    
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
}
