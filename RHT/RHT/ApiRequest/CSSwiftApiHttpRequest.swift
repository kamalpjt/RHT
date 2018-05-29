//
//  SwiftApiHttpRequest.swift
//  vakilsearch
//
//  Created by contus on 14/06/16.
//  Copyright © 2016 contus. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD_0_8_1

typealias JSONResponseBlock =  Dictionary<String, AnyObject>


class CSSwiftApiHttpRequest: UIView {
    
    
   
   
    //MARK:-Get method without header
    /**
     
     this method used send http request in get method  
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func getMethod(url:String, parameter: [String:String], ResponseBlock:(JSONResponseBlock) -> Void){
        
        SVProgressHUD.show()
        
        Alamofire.request(.GET, url ,parameters:parameter).responseJSON { response in
            
            switch response.result {
                
            case .Success:
                
                SVProgressHUD.dismiss()
                print("Validation Successful")
                let JSON = response.result.value
                let airports: [String: AnyObject] = ["Response" : JSON!]
                ResponseBlock(airports)
                //print("JSON: \(JSON)")
                
            case .Failure(let error):
                
                SVProgressHUD.dismiss()
                print(error)
            }
            
            
        }
    }
    
    //MARK:-Get method with header
    /**
     
     this method used send http request in get method and pass userid and token in header
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func getMethodWithHeader(url:String, view:UIView,parameter: [String:String],ResponseBlock:(JSONResponseBlock) -> Void){
        
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]

        Alamofire.Manager.sharedInstance.session.configuration.requestCachePolicy = .ReloadIgnoringLocalCacheData
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
    
        Alamofire.request(.GET, url ,parameters:parameter ,headers: header).responseJSON { response in
            
            SVProgressHUD.dismiss()
            view.userInteractionEnabled = true
            print(response.request)
            print(response.response)
            let statuscode = response.response?.statusCode
            print(statuscode)
            switch response.result {
                
            case .Success:
                
                
               
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    
                    let JSON = response.result.value
                    print(JSON)
                    let responseData: [String: AnyObject] = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 204){
                    
                    let JSON = response.result.value
                    let responseData: [String: AnyObject] = ["Status" :"NODATAFOUND","Response": JSON!]
                    //let responseData = ["Status" :"NODATAFOUND","Response": JSON!]
                    ResponseBlock(responseData)
                    // view.makeToast("No Record Found", duration: TOAST_DUR, position: CSToastPositionCenter)
                }
                
                
            case .Failure(let error):
                 SVProgressHUD.dismiss()
                 
                 if (error.code == -1001){
                    
                    view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
                 }else if (error.code == -1009){
                    
                    view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
                    
                 }else if (statuscode == 502){
                    
                     view.makeToast("Something went wrong try again", duration: TOAST_DUR, position: CSToastPositionCenter)
                    
                }
            }
        }
        
    }
    /**
     this method is used display the  menu item in popup
     
     - parameter url:           baseUrl
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    func getMethodWithHeaderForDrowDown(url:String,parameter: [String:String],ResponseBlock:(JSONResponseBlock) -> Void){
        
        SVProgressHUD.show()
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
        
        Alamofire.request(.GET, url ,parameters:parameter ,headers: header).responseJSON { response in
            
            print(response.request)
            print(response.response)
            let statuscode = response.response?.statusCode
            switch response.result {
                
            case .Success:
                
                SVProgressHUD.dismiss()
                
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    
                    let JSON = response.result.value
                    print(JSON)
                    let responseData: [String: AnyObject] = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 204){
                    
                    let JSON = response.result.value
                    print(JSON)
                    let responseData: [String: AnyObject] = ["Response" : JSON!,"Status" :"NODATA"]
                    ResponseBlock(responseData)
                }else {
                    
                    let JSON = response.result.value
                    print(JSON)
                    let responseData: [String: AnyObject] = ["Response" : JSON!,"Status" :"Some"]
                    ResponseBlock(responseData)
                }
                
                
            case .Failure( _):
                SVProgressHUD.dismiss()
                let JSON = [:]
                let responseData: [String: AnyObject] = ["Response" : JSON,"Status" :"Some"]
                ResponseBlock(responseData)
    
          }
        }
        
    }

    
    //MARK:-Post method with header
    /**
    
     this method used send http request in post method
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
    - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func PostMethod(url:String, view:UIView,Parameter :[String:AnyObject],ResponseBlock:(JSONResponseBlock) -> Void){
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]

        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
        
        Alamofire.request(.POST, url, parameters: Parameter , headers: header).responseJSON { response in
            
            SVProgressHUD.dismiss()
            view.userInteractionEnabled = true
            print(response.request)
            print(response.response)
            
            let statuscode = response.response?.statusCode
            let responseData: [String: AnyObject]
            switch response.result {
                
            case .Success:
                
                
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    let JSON = response.result.value
                    responseData = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 201){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 422){
                    
                    let JSON = response.result.value
                    responseData = ["Status" :"FAILURE","Response": JSON!]
                    ResponseBlock(responseData)
                }
                
                
            case .Failure(let error):
                
                if (error.code == -1001){
                    
                    view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
                }else if (error.code == -1009){
                    
                    view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
                }

                responseData = ["Status" :"FAILURE"]
                
                
            }
            
        }
        
        
    }
    
    //MARK:-PUT method with header
    
    /**
     
     this method used send http request in Put method
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func PutMethod(url:String, view:UIView,Parameter :[String:AnyObject],ResponseBlock:(JSONResponseBlock) -> Void){
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]

        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
        
        Alamofire.request(.PUT, url, parameters: Parameter , headers: header).responseJSON { response in
            
            SVProgressHUD.dismiss()
            view.userInteractionEnabled = true
            print(response.request)
            print(response.response)
            
            let statuscode = response.response?.statusCode
            let responseData: [String: AnyObject]
            switch response.result {
                
            case .Success:
                
                
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    let JSON = response.result.value
                    responseData = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 201){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 204){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 422){
                    let JSON = response.result.value
                    responseData = ["Status" :"FAILURE","Response": JSON!]
                    ResponseBlock(responseData)
                }else if (statuscode == 404){
                    
                  view.makeToast("No Record Found", duration: TOAST_DUR, position: CSToastPositionBottom)
                    
                }
                
                
            case .Failure(let error):
                
    
                if (error.code == -1001){
                    
                    view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
                }else if (error.code == -1009){
                    
                    view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
                }

                responseData = ["Status" :"FAILURE"]
                
                
            }
        }
        
        
    }
    
    /**
     
     this method used send http request in Delete method
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */

    func DeleteMethod(url:String, view:UIView,Parameter :[String:AnyObject],ResponseBlock:(JSONResponseBlock) -> Void){
        
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]

        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
        
        Alamofire.request(.DELETE, url, parameters: Parameter , headers: header).responseJSON { response in
            
            SVProgressHUD.dismiss()
            view.userInteractionEnabled = true
            print(response.request)
            print(response.response)
            
            let statuscode = response.response?.statusCode
            let responseData: [String: AnyObject]
            switch response.result {
                
            case .Success:
                
                
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    let JSON = response.result.value
                    responseData = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 201){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 204){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 422){
                    
                    let JSON = response.result.value
                    responseData = ["Status" :"FAILURE","Response": JSON!]
                    ResponseBlock(responseData)
                }else{
                    
                    let JSON = response.result.value
                    responseData = ["Status" :"FAILURE","Response": JSON!]
                    ResponseBlock(responseData)
                }
                
                
            case .Failure(let error):
                

                if (error.code == -1001){
                    
                    view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
                }else if (error.code == -1009){
                    
                    view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
                }

                responseData = ["Status" :"FAILURE"]
                
                
            }
            
        }
        
    }
    
    //MARK:-PUT method with header
    
    func PutMethod1(url:String,  view:UIView,Parameter :[String:AnyObject],ResponseBlock:(JSONResponseBlock) -> Void){
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]

        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
        
        Alamofire.request(.PUT, url, parameters: Parameter , headers: header).responseJSON { response in
            
            SVProgressHUD.dismiss()
            view.userInteractionEnabled = true
            print(response.request)
            print(response.response)
            
            let statuscode = response.response?.statusCode
            let responseData: [String: AnyObject]
            switch response.result {
                
            case .Success:
                
                
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    let JSON = response.result.value
                    responseData = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 201){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 204){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 422){
                    let JSON = response.result.value
                    responseData = ["Status" :"FAILURE","Response": JSON!]
                    ResponseBlock(responseData)
                }else if (statuscode == 404){
                    
                    let JSON = response.result.value
                    responseData = ["Status" :"NODATAFOUND","Response": JSON!]
                    ResponseBlock(responseData)
                    
                }
                
                
            case .Failure(let error):
                
                SVProgressHUD.dismiss()
                view.userInteractionEnabled = true
                if (error.code == -1001){
                    
                    view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
                }else if (error.code == -1009){
                    
                    view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
                }

                responseData = ["Status" :"FAILURE"]
                
                
            }
        }
    }
    /**
     
     this method used send http request in post method  and send request as raw data(send parameter in json format)
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */

    func PostWithRawData(url:String,  view:UIView,Parameter :[String:AnyObject],ResponseBlock:(JSONResponseBlock) -> Void){
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]

        let headerWithContentType = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN,"content-type":"application/json"]
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
        
        Alamofire.request(.POST, url, parameters: Parameter, headers: headerWithContentType ,encoding:.JSON).responseJSON{ response in
            
            SVProgressHUD.dismiss()
            view.userInteractionEnabled = true
            print(response.request)
            print(response.response)
            
            let statuscode = response.response?.statusCode
            let responseData: [String: AnyObject]
            switch response.result {
                
            case .Success:
                
                
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    let JSON = response.result.value
                    responseData = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 201){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 204){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 422){
                    let JSON = response.result.value
                    responseData = ["Status" :"FAILURE","Response": JSON!]
                    ResponseBlock(responseData)
                }else if (statuscode == 404){
                    
                   view.makeToast("No Record Found", duration: TOAST_DUR, position: CSToastPositionBottom)
                    
                }
                
                
            case .Failure(let error):
                
                SVProgressHUD.dismiss()
                view.userInteractionEnabled = true
                if (error.code == -1001){
                    
                    view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
                }else if (error.code == -1009){
                    
                    view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
                }

                responseData = ["Status" :"FAILURE"]
                
                
            }
            
            
        }
        
    }
    
    /**
     
     this method used send http request in put method  and send request as raw data(send parameter in json format)
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    func PutWithRawData(url:String, view:UIView,Parameter :[String:AnyObject],ResponseBlock:(JSONResponseBlock) -> Void){
        
        SVProgressHUD.show()
        view.userInteractionEnabled = false
        let headerWithContentType = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN,"content-type":"application/json"]
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]

        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
        
        Alamofire.request(.PUT, url, parameters: Parameter, headers: headerWithContentType ,encoding:.JSON).responseJSON{ response in
            
             SVProgressHUD.dismiss()
            view.userInteractionEnabled = true
            print(response.request)
            print(response.response)
            
            let statuscode = response.response?.statusCode
            let responseData: [String: AnyObject]
            switch response.result {
                
            case .Success:
                
                
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    let JSON = response.result.value
                    responseData = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                    
                }else if (statuscode == 201){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 204){
                    
                    responseData = ["Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 422){
                    let JSON = response.result.value
                    responseData = ["Status" :"FAILURE","Response": JSON!]
                    ResponseBlock(responseData)
                }else if (statuscode == 404){
                    
                  
                    view.makeToast("No Record Found", duration: TOAST_DUR, position: CSToastPositionBottom)
                  
                    
                }
                
                
            case .Failure(let error):
                
                SVProgressHUD.dismiss()
                view.userInteractionEnabled = true
                if (error.code == -1001){
                    
                    view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter) 
                }else if (error.code == -1009){
                    
                    view.makeToast("The Internet connection appears to be offline.", duration: TOAST_DUR, position: CSToastPositionCenter)
                }

                responseData = ["Status" :"FAILURE"]
                ResponseBlock(responseData)
                
            }
            
            
        }
        
    }
    
    //MARK:-Get method with header
    /**
     
     this method used send http request in get method
     
     - parameter url:           baseUrl
     - parameter view:          view is used to identify from  which viewController the request send and display the toast message.
     - parameter parameter:     contains list of parameter to pass to server
     - parameter ResponseBlock: responseBlock is the call back method used to pass response to view controller
     */
    
    func getMethodWithHeaderForCourtList(url:String, view:UIView,parameter: [String:String],ResponseBlock:(JSONResponseBlock) -> Void){
        
      
        let header = ["UserId": "\(CSSharedMethod.getUserDefaultValue(USERID))",API_TOKEN: TOKEN]
        
        Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = header
        
        Alamofire.request(.GET, url ,parameters:parameter ,headers: header).responseJSON { response in
            
            print(response.request)
            print(response.response)
            let statuscode = response.response?.statusCode
            print(statuscode)
            switch response.result {
                
            case .Success:
                
                if ( statuscode == 200){
                    
                    print("Validation Successful")
                    
                    let JSON = response.result.value
                    print(JSON)
                    let responseData: [String: AnyObject] = ["Response" : JSON!,"Status" :"SUCESS"]
                    ResponseBlock(responseData)
                }else if (statuscode == 204){
                    
                    let JSON = response.result.value
                    let responseData = ["Status" :"NODATAFOUND","Response": JSON!]
                    ResponseBlock(responseData)
                }
                
                
            case .Failure(let error):
                SVProgressHUD.dismiss()
                
                if (error.code == -1001){
                    
                    view.makeToast("The request timed out", duration: TOAST_DUR, position: CSToastPositionCenter)
                }else if (error.code == -1009){
                    
                    view.makeToast("The Internet connection appears to be offline", duration: TOAST_DUR, position: CSToastPositionCenter)
                }else{
                     view.makeToast("Something went wrong try again", duration: TOAST_DUR, position: CSToastPositionCenter)
                }
            }
        }
        
    }


    
}



