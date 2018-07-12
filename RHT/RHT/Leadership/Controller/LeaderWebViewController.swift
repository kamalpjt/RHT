//
//  LeaderWebViewController.swift
//  RHT
//
//  Created by kamal on 05/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import Alamofire
class LeaderWebViewController: BaseViewController,UIWebViewDelegate,URLSessionDelegate,URLSessionDownloadDelegate {
    @IBOutlet weak var wvPdfWebView: UIWebView!
    var pdfurl:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        wvPdfWebView.delegate = self
        //wvPdfWebView.loadRequest(URLRequest(url: URL(string:pdfurl!)!))
        //wvPdfWebView.request?.cachePolicy = .returnCacheDataElseLoad

      //  HttpRequestMethod.sharedInstance.downloadFile(url: pdfurl!)
//        let urls = URL(string:pdfurl!)!
//        var urlRequest = URLRequest(url: urls)
//        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        //wvPdfWebView.loadRequest(urlRequest)
        // Do any additional setup after loading the view.
      //  let documentDirectoryPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
       // let imagesDirectoryPath = documentDirectoryPath?.appending(AppConstant.sharedInstance.LOCALPDFFOLDER)
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let destinationFileUrl = documentsUrl.appendingPathComponent(AppConstant.sharedInstance.LOCALPDFFOLDER);
        let gffgf = destinationFileUrl.appendingPathComponent("downloadedFile.pdf")
        
        //Create URL to the source file you want to download
        let fileURL = URL(string: pdfurl!)
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession.init(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue())
        let request = URLRequest(url:fileURL!)
        let task  = session.downloadTask(with: request)
//        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//            if let tempLocalUrl = tempLocalUrl, error == nil {
//                // Success
//                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                    print("Successfully downloaded. Status code: \(statusCode)")
//                }
//
//                do {
//                    try FileManager.default.copyItem(at: tempLocalUrl, to: gffgf)
//                } catch (let writeError) {
//                    print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                }
//
//            } else {
//                print("Error took place while downloading a file. Error description: %@", error?.localizedDescription);
//            }
//        }
        task.resume()
        
    }
    private func calculateProgress(session : URLSession, completionHandler : @escaping (Float) -> ()) {
        session.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
            let progress = downloads.map({ (task) -> Float in
                if task.countOfBytesExpectedToReceive > 0 {
                    return Float(task.countOfBytesReceived) / Float(task.countOfBytesExpectedToReceive)
                } else {
                    return 0.0
                }
            })
          //  completionHandler(progress.reduce(0.0, +))
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        //if totalBytesExpectedToWrite > 0 {
//            if let onProgress = onProgress {
//                //calculateProgress(session: session, completionHandler: onProgress)
//            }
        print(totalBytesExpectedToWrite * 1024 * 20124)
            let progress = Float(bytesWritten) / Float(totalBytesWritten)
           // debugPrint("Progress \(downloadTask) \(progress)")
            
      //  }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint("Download finished: \(location)")
        try? FileManager.default.removeItem(at: location)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        debugPrint("Task completed: \(task), error: \(error)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.dismiss()
        SharedAlert.instance.ShowAlert(title: StringConstant.instance.ALERTTITLE, message: "Try again", viewController: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
