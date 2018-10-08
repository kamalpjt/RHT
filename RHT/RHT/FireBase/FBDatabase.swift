//
//  FBDatabase.swift
//  RHT
//
//  Created by kamal on 08/09/18.
//  Copyright © 2018 rht. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
class FBDatabase {
    
    var ref: DatabaseReference!
    
    func addUserToFireBase() -> Void{
        ref = Database.database().reference()
        let userData = ["email":UserDetail.Instance.email!,"firebaseToken":"",
                        "name":UserDetail.Instance.name!,"timestamp":0,
                        "uid":UserDetail.Instance.id!,"unreadCount":0] as [String : Any]
        let userefrence = self.ref.child("users").child(UserDetail.Instance.id!)
        userefrence.updateChildValues(userData) { (err, rf) in
            
            if(err != nil)
            {
                debugPrint("FB user data added not sucessfully")
            }else{
                debugPrint("FB user data added sucessfully")
            }
        }
    }
    
    func addMessageToFireBase(agentMenu:String,message:String,messageType:String,receiver:String,receiverUid:String,sender:String,
                              senderUid:String,timestamp:String) -> Void {
        ref = Database.database().reference()
        let userefrence = self.ref.child("chat_rooms").child("624167ea-7c58-11e8-89ed-b551f2bf21b9_"+UserDetail.Instance.id!).child(timestamp)
        let messageData = ["agentMenu":agentMenu,"message":message,
                           "messageType":messageType,"receiver":receiver,
                           "receiverUid":receiverUid,"sender":sender,
                           "senderUid":senderUid,"timestamp":timestamp]
        userefrence.updateChildValues(messageData) { (err, rf) in
            
            if(err != nil)
            {
                debugPrint("FB message data added not sucessfully")
            }else{
                debugPrint("FB message data added sucessfully")
            }
        }
        
    }
    
    func getAllUser(tableView:UITableView) -> Void {
        var users = [FirebaseUserList()]
        ref = Database.database().reference()
        ref.child("users").observe(DataEventType.childAdded, with: { (snapshot) in
            debugPrint(snapshot)
         
            if let dictionarys = snapshot.value as? [String:AnyObject] {
                  let user = FirebaseUserList()
                user.setValuesForKeys(dictionarys)
                users.append(user)
                tableView.reloadData()
               // debugPrint(user.name,user.email)
            }
        }) { (error) in
            debugPrint(error)
        }
        
    }
}
