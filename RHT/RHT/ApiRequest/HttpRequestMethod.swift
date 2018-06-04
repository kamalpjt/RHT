//
//  HttpRequest.swift
//  RHT
//
//  Created by kamal on 5/25/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import Alamofire
typealias jsonResponseSucessBlock = (Data) -> Void
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
        let headerWithContentType = ["content-type":"application/json"]
        let ggg = AppConfig.sharedInstance.RHTDDevIp!+url
        request(AppConfig.sharedInstance.RHTDDevIp!+url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headerWithContentType).responseData(completionHandler: {response in
            if(response.error == nil){
                
                sucessResponseBlcok(response.data!);
//                do {
//
//                   // let course = try JSONDecoder().decode(UserDetailModel.self, from: response.data!)
//                    print(course)
//                } catch let jsonerror {
//                    let statuscode = response.response?.statusCode
//                    print(jsonerror)
//                }
            }else{
                
                print(response.error!)
                failureResponseBlcok(response.error! as AnyObject)
            }
        })
    }
    func putMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
    func deleteMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
}
