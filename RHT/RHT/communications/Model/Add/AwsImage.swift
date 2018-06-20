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

protocol AwsDelegate {
    
}

class AwsImage {
    var m_selectedImageUrl:NSURL?
    var m_selectedImage:UIImage?
    init(selectedImageUrl:NSURL,selectedImage:UIImage) {
        m_selectedImageUrl = selectedImageUrl
        m_selectedImage = selectedImage
        
    }
    func getLocalImageFileName()  {
        SVProgressHUD.show(withStatus: "Uploading")
        if let imageToUploadUrl = m_selectedImageUrl
        {
            if let asset = PHAsset.fetchAssets(withALAssetURLs: [imageToUploadUrl as URL], options: nil).firstObject {
                
                PHImageManager.default().requestImageData(for: asset, options: nil, resultHandler: { _, _, _, info in
                    
                    if let fileName = (info?["PHImageFileURLKey"] as? NSURL)?.lastPathComponent {
                        //do sth with file name
                        print(fileName)
                        self.startUploadingImage(localFileName: fileName)
                    }
                })
            }
            
        }
    }
    func startUploadingImage(localFileName:String)
    {
        let S3BucketName = AppConstant.sharedInstance.IMAGEBUCKETNAME
        let remoteName = localFileName
        
        let uploadRequest = AWSS3TransferManagerUploadRequest()
        uploadRequest?.body = generateImageUrl(fileName: remoteName)
        uploadRequest?.key = remoteName
        uploadRequest?.bucket = S3BucketName
        uploadRequest?.contentType = "image/jpeg"
        
        
        let transferManager = AWSS3TransferManager.default()
        
        // Perform file upload
        transferManager.upload(uploadRequest!).continueWith { (task) -> AnyObject? in
            
            DispatchQueue.main.async {
                //self.imageView.image = image
            }
            if let error = task.error {
                print("Upload failed with error: (\(error.localizedDescription))")
            }
            
            //            if let exception = task.exe {
            //                print("Upload failed with exception (\(exception))")
            //            }
            
            if task.result != nil {
                
                let s3URL = NSURL(string: "https://s3-ap-southeast-1.amazonaws.com/\(S3BucketName)/\(uploadRequest?.key! ?? "")")!
                print("Uploaded to:\n\(s3URL)")
                // Remove locally stored file
                self.remoteImageWithUrl(fileName: (uploadRequest?.key!)!)
                
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
    func generateImageUrl(fileName: String) -> URL
    {
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
        let data = UIImageJPEGRepresentation(m_selectedImage!, 0.6)
        
        do {
            try data?.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
        }
        //data!.writeToURL(fileURL, atomically: true)
        
        return fileURL
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
