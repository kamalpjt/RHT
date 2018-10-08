//
//  ChatUserListVC.swift
//  RHT
//
//  Created by kamal on 20/09/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ChatUserListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    @IBOutlet weak var tblUserList: UITableView!
     var users = [FirebaseUserList()]
    var ref: DatabaseReference!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       // tblUserList.delegate = self
       // tblUserList.dataSource = self
        users.removeAll()
        getAllUser();
       
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getAllUser() -> Void {
       
        ref = Database.database().reference()
        ref.child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            debugPrint(snapshot)
            
            if let dictionarys = snapshot.value as? [String:AnyObject] {
                let user = FirebaseUserList()
                user.setValuesForKeys(dictionarys)
               
               // if user.name! != nil{
                    self.users.append(user)
                 debugPrint("name:"+(user.name!))
                debugPrint("count:"+String(self.users.count))
                    DispatchQueue.main.async {
                        self.tblUserList.reloadData()
                  //  }
                }
                // debugPrint(user.name,user.email)
            }
        }) { (error) in
            debugPrint(error)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //debugPrint("name:"+(users[section].name!))
        return users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserCell
        cell.lblUserName.text = users[indexPath.row].name;
        let cons = Int(truncating: users[indexPath.row].unreadCount)
        cell.lblCount.text =  String(cons)
        
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
//        cell.imageView?.image = UIImage(named: "Redprofile");
//        cell.textLabel?.text = users[indexPath.row].name;
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let udid = users[indexPath.row].uid;
        let chatuser =   self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        chatuser.chatSelectedUserUdid = udid;
        self.navigationController?.pushViewController(chatuser, animated: true)
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
