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
    func getLoginDetail (url:String,param:[String:String],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let login = try JSONDecoder().decode(UserDetailModel.self, from: sucessresponse)
                 
                    resposneBlock(login, statuscode)
                }
               // let json  = try JSONSerialization.jsonObject(with: sucessresponse, options: .mutableContainers)
               
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            
            SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: failureResponse.description, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
        })
    }
}
