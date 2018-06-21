//
//  DeleteAwsImage.swift
//  RHT
//
//  Created by kamal on 6/21/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import AWSS3
class DeleteAwsImage {
    
    static let instance  = DeleteAwsImage()
    
    
    func DeleteImage(imageName:String) {
        
        let s3Service = AWSS3.default()
        let deleteObjectRequest = AWSS3DeleteObjectRequest()
        deleteObjectRequest?.bucket = AppConstant.sharedInstance.IMAGEBUCKETNAME // bucket name
        deleteObjectRequest?.key = imageName // File name
        s3Service.deleteObject(deleteObjectRequest!).continueWith { (task:AWSTask) -> AnyObject? in
            if let error = task.error {
                print("Error occurred: \(error)")
                return nil
            }
            print("Bucket deleted successfully.")
            return nil
        }
        
    }
}
