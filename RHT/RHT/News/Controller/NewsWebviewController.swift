//
//  NewsWebviewController.swift
//  RHT
//
//  Created by kamal on 04/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class NewsWebviewController: UIViewController,UIWebViewDelegate {
    @IBOutlet weak var wvNews: UIWebView!
    var m_HtmlString:String?
    override func viewDidLoad() {
        super.viewDidLoad()

        wvNews.delegate = self
        print(m_HtmlString!)
        wvNews.loadHTMLString(m_HtmlString!, baseURL: nil)
      //  wvNews.st
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
