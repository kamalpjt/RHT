//
//  HttpRequest.swift
//  RHT
//
//  Created by kamal on 5/25/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import Alamofire
typealias jsonResponseBlock = AnyObject
struct Courses:Decodable {
    let id:Int?
    let name:String?
    let link:String?
    let image_url:String?
    let number_of_lessons:Int?
}
class HttpRequestMethod {
    
     static let sharedInstance = HttpRequestMethod()
    
    func getMethod(url:String,responseBlcok:(jsonResponseBlock) -> Void){
        
        //request(<#T##url: URLConvertible##URLConvertible#>, method_getName(.get))
       // request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
        // Alamofire 4
        let parameters: Parameters = ["foo": "bar"]
        
        Alamofire.request(url).response { response in // method defaults to `.get`
            
            if(response.error == nil){
                do {
                    
                    let course = try JSONDecoder().decode([Courses].self, from: response.data!)
                    print(course)
                } catch let jsonerror {
                    
                    print(jsonerror)
                }
            }else{
                print(response.error!)
            }
        }
    }
    func postMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
    func putMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
    func deleteMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
}
