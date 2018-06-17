//
//  CommunicationParsing.swift
//  RHT
//
//  Created by kamal on 15/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
class CommunicationParsing {
    static let instance = CommunicationParsing()
    func getResponseDetail (url:String,param:[String:Any],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse, statuscode in
            do {
                if(statuscode==200){
                    let model = try JSONDecoder().decode(AddModel.self, from: sucessresponse)
                    if model.statusCode == AppConstant.sharedInstance.INTERNALSUCESSCODE {
                    resposneBlock(model, statuscode)
                        
                    }else{
                        
                        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: model.statusMessage!, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
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
