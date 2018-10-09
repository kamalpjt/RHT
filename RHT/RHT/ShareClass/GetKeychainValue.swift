//
//  GetKeychainValue.swift
//  RHT
//
//  Created by kamal on 09/10/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class GetKeychainValue {
    
     static let Instance = GetKeychainValue()
    
    func getUserDataFromKeyChain () -> Void{
        
         do {
            let retrievedString: String? = KeychainWrapper.standard.string(forKey: AppConstant.sharedInstance.SAVELOGINDETAIL)
            let data = retrievedString?.data(using: .utf8)!
            let value = try JSONDecoder().decode(UserDetailModel.self, from: data!)
            UserDetail.Instance.isStaff = value.response.user.isStaff!
            UserDetail.Instance.email = value.response.user.email!
            UserDetail.Instance.phone = value.response.user.phone!
            UserDetail.Instance.name = value.response.user.name!
            UserDetail.Instance.password = value.response.user.password!
            UserDetail.Instance.user_type = value.response.user.user_type!
            UserDetail.Instance.userid = value.response.user.userid!
            UserDetail.Instance.id = value.response.user.id!
            UserDetail.Instance.isHeadStaff = value.response.user.isHeadStaff!
            UserDetail.Instance.genPostAdmin = value.response.user.genPostAdmin!
            UserDetail.Instance.isVerified = value.response.user.isVerified!
            
         }catch  let jsonerror {
            
            print(jsonerror)
        }
        
    }
}
