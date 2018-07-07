//
//  MatterParsing.swift
//  RHT
//
//  Created by kamal on 01/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class MatterParsing {
    
    static let instance = MatterParsing()
    func getMatterList (url:String,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(CommunicationModel.self, from: sucessresponse)
                    
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SVProgressHUD.dismiss()
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            SVProgressHUD.dismiss()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    
    func getClientList (url:String,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(ClientModel.self, from: sucessresponse)
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SVProgressHUD.dismiss()
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            SVProgressHUD.dismiss()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    
    func getCommunicationDetailList (url:String,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(MatterDetailModel.self, from: sucessresponse)
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SVProgressHUD.dismiss()
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            SVProgressHUD.dismiss()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    
    func getNewsList (url:String,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(NewsModel.self, from: sucessresponse)
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SVProgressHUD.dismiss()
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            SVProgressHUD.dismiss()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    
    func getLeaderList (url:String,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(LeaderModel.self, from: sucessresponse)
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SVProgressHUD.dismiss()
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            SVProgressHUD.dismiss()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    func getCommentList (url:String,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(CommentListModel.self, from: sucessresponse)
                    if login.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                        resposneBlock(login, statuscode)
                        
                    }else{
                        SVProgressHUD.dismiss()
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: login.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    }
                }
                
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            SVProgressHUD.dismiss()
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
    
}
