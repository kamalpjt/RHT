//
//  SettingViewController.swift
//  RHT
//
//  Created by vinoth on 07/04/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class SettingViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    
    var data:[String] = []
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        data.append("ChangePassowrd")
        data.append("Signout");
        tblView.dataSource = self
        tblView.delegate = self
        tblView.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let myCell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "myIdentifier")
        myCell.textLabel?.font = UIFont.systemFont(ofSize: ShareData.SetFont14(), weight: .regular)
        myCell.textLabel?.text = data[indexPath.row];
        myCell.selectionStyle = .none
        return myCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
           self.sideMenuViewController.hideViewController()
            NotificationCenter.default.post(name: Notification.Name(AppConstant.sharedInstance.SELECTEDINDEXPATH), object: nil, userInfo: ["Indexpath":indexPath.row])
        }else if indexPath.row == 1 {
            
            var storyboard:UIStoryboard ;
            if ShareData.isIpad(){
                storyboard = UIStoryboard.init(name: "Loginipad", bundle: Bundle.main)
            }else{
                storyboard = UIStoryboard.init(name: "Login", bundle: Bundle.main)
            }
            
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
            let navController = UINavigationController(rootViewController: rootViewController)
            UIApplication.shared.keyWindow?.rootViewController  = navController;
            
        }
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
