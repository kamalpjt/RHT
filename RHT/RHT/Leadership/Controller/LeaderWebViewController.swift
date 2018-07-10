//
//  LeaderWebViewController.swift
//  RHT
//
//  Created by kamal on 05/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import Alamofire
class LeaderWebViewController: BaseViewController,UIWebViewDelegate {
    @IBOutlet weak var wvPdfWebView: UIWebView!
    var pdfurl:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        wvPdfWebView.delegate = self
        //wvPdfWebView.loadRequest(URLRequest(url: URL(string:pdfurl!)!))
        //wvPdfWebView.request?.cachePolicy = .returnCacheDataElseLoad

        
        let urls = URL(string:pdfurl!)!
        var urlRequest = URLRequest(url: urls)
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        wvPdfWebView.loadRequest(urlRequest)
        // Do any additional setup after loading the view.
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
