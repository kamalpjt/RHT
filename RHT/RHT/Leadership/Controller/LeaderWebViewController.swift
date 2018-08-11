//
//  LeaderWebViewController.swift
//  RHT
//
//  Created by kamal on 05/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import Alamofire
//extension Date {
//    /// Returns the amount of years from another date
//    func years(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
//    }
//    /// Returns the amount of months from another date
//    func months(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
//    }
//    /// Returns the amount of weeks from another date
//    func weeks(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
//    }
//    /// Returns the amount of days from another date
//    func days(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
//    }
//    /// Returns the amount of hours from another date
//    func hours(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
//    }
//    /// Returns the amount of minutes from another date
//    func minutes(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
//    }
//    /// Returns the amount of seconds from another date
//    func seconds(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
//    }
//    /// Returns the amount of nanoseconds from another date
//    func nanoseconds(from date: Date) -> Int {
//        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
//    }
//    /// Returns the a custom time interval description from another date
//    func offset(from date: Date) -> String {
//        if years(from: date)   > 0 { return "\(years(from: date))y"   }
//        if months(from: date)  > 0 { return "\(months(from: date))M"  }
//        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
//        if days(from: date)    > 0 { return "\(days(from: date))d"    }
//        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
//        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
//        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
//        if nanoseconds(from: date) > 0 { return "\(nanoseconds(from: date))ns" }
//        return ""
//    }
//}

class LeaderWebViewController: BaseViewController,UIWebViewDelegate,URLSessionDelegate,URLSessionDownloadDelegate {
    @IBOutlet weak var wvPdfWebView: UIWebView!
    var m_pdfurl:String?
    var m_destinationFileUrl:URL?
    override func viewDidLoad() {
        super.viewDidLoad()
       // getAllItem()
        wvPdfWebView.delegate = self
        let pdfArray = m_pdfurl?.components(separatedBy: "/")
        let documentsUrl:URL =  (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL?)!
        let FileUrl = documentsUrl.appendingPathComponent(AppConstant.sharedInstance.LOCALPDFFOLDER);
        m_destinationFileUrl = FileUrl.appendingPathComponent((pdfArray?.last)!)
        
        if FileManager.default.fileExists(atPath: (m_destinationFileUrl?.path)!){
            let  getUrl = URLRequest.init(url: m_destinationFileUrl!)
            wvPdfWebView.loadRequest(getUrl)
        }else{
            //Create URL to the source file you want to download
            let fileURL = URL(string: m_pdfurl!.replacingOccurrences(of:  " ", with: "%20"))
            let sessionConfig = URLSessionConfiguration.default
            let session = URLSession.init(configuration: sessionConfig, delegate: self, delegateQueue: OperationQueue())
            let request = URLRequest(url:fileURL!)
            let task  = session.downloadTask(with: request)
            task.resume()
            
        }
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        SVProgressHUD.dismiss()
    }
    
    
    
    func SubmitButton() -> UIBarButtonItem{
        let menuButton = UIButton.init(type: UIButtonType.custom)
        menuButton.setTitle("Share", for: UIControlState.normal)
        menuButton.addTarget(self, action:#selector(SubmitAction), for: UIControlEvents.touchUpInside)
        let barbutton = UIBarButtonItem.init(customView: menuButton)
        return barbutton
    }
    @objc func SubmitAction() -> Void{
        loadPDFAndShare()
    }
    
    func loadPDFAndShare(){
        if FileManager.default.fileExists(atPath: (m_destinationFileUrl?.path)!){
            let documento = NSData(contentsOfFile: (m_destinationFileUrl?.path)!)
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [documento!], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView=self.view
            present(activityViewController, animated: true, completion: nil)
        }
        else {
            print("document was not found")
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
            if( self.navigationController != nil){
                SVProgressHUD.showProgress(progress1 * 100)
            }
            
        }
        
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        debugPrint("Download finished: \(location)")
        
        do {
            try FileManager.default.copyItem(at: location, to: m_destinationFileUrl!)
            let  getUrl = URLRequest.init(url: m_destinationFileUrl!)
            DispatchQueue.main.async{
                /*Write your thread code here*/
                self.wvPdfWebView.loadRequest(getUrl)
            }
            
        } catch (let writeError) {
            print("Error creating a file \(String(describing: m_destinationFileUrl)) : \(writeError)")
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
        navigationItem.rightBarButtonItems = [SubmitButton()]
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
