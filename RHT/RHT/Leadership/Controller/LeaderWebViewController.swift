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
    var destinationFileUrl:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wvPdfWebView.delegate = self
        
         let pdfArray = pdfurl?.components(separatedBy: "/")
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let FileUrl = documentsUrl.appendingPathComponent(AppConstant.sharedInstance.LOCALPDFFOLDER);
        destinationFileUrl = FileUrl.appendingPathComponent((pdfArray?.last)!)
        
        if FileManager.default.fileExists(atPath: (destinationFileUrl?.path)!){
            let  getUrl = URLRequest.init(url: destinationFileUrl!)
            wvPdfWebView.loadRequest(getUrl)
        }else{
            //Create URL to the source file you want to download
            let fileURL = URL(string: pdfurl!)
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession.init(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue())
            let request = URLRequest(url:fileURL!)
            let task  = session.downloadTask(with: request)
            task.resume()
        }
        
       
        
    }
    private func calculateProgress(session : URLSession) {
        session.getTasksWithCompletionHandler { (tasks, uploads, downloads) in
            let progress = downloads.map({ (task) -> Float in
                if task.countOfBytesExpectedToReceive > 0 {
                    return Float(task.countOfBytesReceived) / Float(task.countOfBytesExpectedToReceive)
                } else {
                    return 0.0
                }
            })
            print(progress.reduce(0.0, +))
            //completionHandler(progress.reduce(0.0, +))
        }
    }
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let progress1 =  Float(bytesWritten) / Float(totalBytesWritten)
        DispatchQueue.main.async{
            /*Write your thread code here*/
            SVProgressHUD.showProgress(progress1 * 100)
        }
        
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint("Download finished: \(location)")
        
        do {
            try FileManager.default.copyItem(at: location, to: destinationFileUrl!)
            let  getUrl = URLRequest.init(url: destinationFileUrl!)
            DispatchQueue.main.async{
                    /*Write your thread code here*/
                self.wvPdfWebView.loadRequest(getUrl)
            }
          
        } catch (let writeError) {
            print("Error creating a file \(String(describing: destinationFileUrl)) : \(writeError)")
        }
        try? FileManager.default.removeItem(at: location)
       
        DispatchQueue.main.async{
            /*Write your thread code here*/
            SVProgressHUD.dismiss()
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        debugPrint("Task completed: \(task), error: \(String(describing: error))")
        DispatchQueue.main.async{
            /*Write your thread code here*/
            SVProgressHUD.dismiss()
        }
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
