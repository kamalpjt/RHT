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
extension Dictionary {
    mutating func unionInPlace(
        dictionary: Dictionary<Key, Value>) {
        for (key, value) in dictionary {
            self[key] = value
        }
    }
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
                  //  let statuscode = response.response?.statusCode
                    print(jsonerror)
                }
            }else{
                
                print(response.error!)
            }
        }
    }
    
    func postMethod(url:String,withLoader:Bool, parameters:[String:Any],sucessResponseBlcok:@escaping (jsonResponseSucessBlock),failureResponseBlcok:@escaping (jsonResponseFailureBlock)) -> Void{
        
        if withLoader {
            SVProgressHUD.show()
        }
        
        let headerWithContentType = ["content-type":"application/json"]
        request(AppConfig.sharedInstance.RHTDDevIp!+url, method: HTTPMethod.post, parameters: parameters, encoding: JSONEncoding.default, headers: headerWithContentType).responseData(completionHandler: {response in
            if (response.result.isSuccess){
                SVProgressHUD.dismiss()
                do{
                        let oobj = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        debugPrint(oobj)
                } catch (let er){
                    debugPrint(er)
                }
                sucessResponseBlcok(response.data!,(response.response?.statusCode)!);
                //do your json stuff
            } else if (response.result.isFailure) {
                SVProgressHUD.dismiss()
                //Manager your error
                switch (response.error!._code){
                case NSURLErrorTimedOut:
                    //Manager your time out error
                    SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: StringConstant.instance.TIMEOUT, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    break
                case NSURLErrorNotConnectedToInternet:
                    SharedAlert.instance.OffLineAlert(viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
                    //Manager your not connected to internet error
                    break
                default:
                    //manager your default case
                    failureResponseBlcok(response.error! as AnyObject)
                    break
                }
            }
            /*if(response.error == nil){
             
             if((response.response?.statusCode)! == 200){
             
             }
             
             
             }else{
             //https://stackoverflow.com/questions/42698516/trying-to-access-error-code-in-alamofire
             //                print(response.result.ifSuccess {
             //                    <#code#>
             //                })
             print(response.response?.statusCode)
             SVProgressHUD.dismiss()
             if( response.error!.localizedDescription == "The request timed out."){
             SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: response.error!.localizedDescription, viewController: (UIApplication.shared.keyWindow?.rootViewController)!)
             }else{
             failureResponseBlcok(response.error! as AnyObject)
             }
             
             }*/
        })
    }
    func putMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
    func deleteMethod(url:String,Parameter:[String:String]) -> Void{
        
    }
    func downloadFile(url:String) -> Void{
        
//        request("").downloadProgress { (progrrgd) in
//
//            }.response { (ressddata) in
//
//        }
        let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
        let imagesDirectoryPath = documentDirectoryPath?.appending(AppConstant.sharedInstance.LOCALPDFFOLDER)
        print(imagesDirectoryPath!)
        
       // download("", to: imagesDirectoryPath).downloadProgress(queue: OperationQueue()) { (cxcxc) in
            
       // }
    }
}
