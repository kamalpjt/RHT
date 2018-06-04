//
//  LoginParsing.swift
//  RHT
//
//  Created by kamal on 04/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
typealias parsedJsonData = (Any) -> Void
class LoginParsing {
    
    static let instance = LoginParsing()
    func getLoginDetail (url:String,param:[String:String],resposneBlock:@escaping(parsedJsonData)) -> Void{
        
        HttpRequestMethod.sharedInstance.postMethod(url: url, parameters: param, sucessResponseBlcok: {sucessresponse in
            do {
                
                let json  = try JSONSerialization.jsonObject(with: sucessresponse, options: .mutableContainers)
            let login = try JSONDecoder().decode(UserDetailModel.self, from: sucessresponse)
                //let login =  UserDetailModel(json:json as! [String : Any]);
                resposneBlock(login)
            } catch let jsonerror {
                print(jsonerror)
            }
        }, failureResponseBlcok: {failureResponse in
            
        })
    }
}
