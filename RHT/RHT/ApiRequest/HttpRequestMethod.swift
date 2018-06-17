//
//  HttpRequest.swift
//  RHT
//
//  Created by kamal on 5/25/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import Alamofire
typealias jsonResponseSucessBlock = (Data,Int) -> Void
typealias jsonResponseFailureBlock = (AnyObject) -> Void
struct Courses:Decodable {
    let id:Int?
    let name:String?
    let link:String?
    let image_url:String?
    let number_of_lessons:Int?
}
class HttpRequestMethod {
    
     static let sharedInstance = HttpRequestMethod()
    
    func getMethod(url:String,responseBlcok:(jsonResponseSucessBlock) -> Void){
        
        Alamofire.request(url).response { response in // method defaults to `.get`
            
            if(response.error == nil){
                do {
                    
                    let course = try JSONDecoder().decode([Courses].self, from: response.data!)
                    print(course)
                } catch let jsonerror {
                    let statuscode = response.response?.statusCode
                    print(jsonerror)
                }
            }else{
                
                print(response.error!)
            }
        }
    }
    func postMethod(url:String,parameters:[String:Any],sucessResponseBlcok:@escaping (jsonResponseSucessBlock),failureResponseBlcok:@escaping (jsonResponseFailureBlock)) -> Void{
      
         SVProgressHUD.show()
        let headerWithContentType = ["content-type":"application/json"]
        request(AppConfig.sharedInstance.RHTDDevIp!+url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headerWithContentType).responseData(completionHandler: {response in
            if(response.error == nil){
                 SVProgressHUD.dismiss()
                if((response.response?.statusCode)! == 200){
                     sucessResponseBlcok(response.data!,(response.response?.statusCode)!);
                }
               
                
            }else{
                print(response.error!)
                 SVProgressHUD.dismiss()
                if( response.error!.localizedDescription == "The request timed out."){
                    SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: response.error!.localizedDescription, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                }else{
                     failureResponseBlcok(response.error! as AnyObject)
                }
               
            }
        })
    }
    func putMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
    func deleteMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
}
