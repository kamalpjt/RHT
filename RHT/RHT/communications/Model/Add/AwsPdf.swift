//
//  AwsImage.swift
//  RHT
//
//  Created by kamal on 20/06/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import AWSS3
import Photos
import SVProgressHUD

protocol AwsPdfDelegate {
    
    func getAwsPdfUrl(url:NSURL)
    
}

class AwsPdf {
    var m_selectedImageUrl:URL?
    var m_delegate:AwsPdfDelegate?
  //  var m_contentType:String?
   // var m_S3BucketName:String?
    init(selectedImageUrl:URL,delegate:AwsPdfDelegate) {
        m_selectedImageUrl = selectedImageUrl
        m_delegate = delegate
      //  m_contentType = contentType
       // m_S3BucketName = S3BucketName
        
    }
    func getLocalImageFileName()  {
        SVProgressHUD.show(withStatus: "Uploading")
        if let imageToUploadUrl = m_selectedImageUrl
        {
            print(imageToUploadUrl)
            let randomString = self.randomString(length: 5) + ".pdf";
            self.startUploadingImage(localFileName: randomString)
            
        }
    }
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    func startUploadingImage(localFileName:String)
    {
        let S3BucketName = AppConstant.sharedInstance.PDFEBUCKETNAME
        let remoteName = localFileName
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.body =  m_selectedImageUrl!
        uploadRequest?.key = remoteName
        uploadRequest?.bucket = S3BucketName
        uploadRequest?.contentType = AppConstant.sharedInstance.CONTENTTYPEPDF
        
        
        let transferManager = AWSS3TransferManager.default()
        
        uploadRequest?.uploadProgress = {(bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            DispatchQueue.main.async(execute: {() -> Void in
                //Update progress
                print(String(totalBytesSent) + ":TotalSize:" + String(totalBytesExpectedToSend))
            })
        }
        // Perform file upload
        transferManager.upload(uploadRequest!).continueWith { (task) -> AnyObject? in
            
            DispatchQueue.main.async {
                //self.imageView.image = image
            }
            if let error = task.error {
                print("Upload failed with error: (\(error.localizedDescription))")
                SVProgressHUD.dismiss()
            }
            
            //            if let exception = task.exe {
            //                print("Upload failed with exception (\(exception))")
            //            }
            
            if task.result != nil {
                
                let s3URL = NSURL(string: "https://s3-ap-southeast-1.amazonaws.com/\(S3BucketName)/\(uploadRequest?.key! ?? "")")!
                print("Uploaded to:\n\(s3URL)")
                self.m_delegate?.getAwsPdfUrl(url: s3URL)
                // Remove locally stored file
               // self.remoteImageWithUrl(fileName: (uploadRequest?.key!)!)
                
                DispatchQueue.main.async {
                    // self.imageView.image = image
                    SVProgressHUD.dismiss()
                }
                
                
            }
            else {
                print("Unexpected empty result.")
            }
            return nil
        }
    }
    func remoteImageWithUrl(fileName: String)
    {
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()+fileName)
        do {
            try FileManager.default.removeItem(at: fileURL)
        } catch
        {
            print(error)
        }
    }
    
}
