//
//  FireBaseMessageList.swift
//  RHT
//
//  Created by kamal on 15/11/18.
//  Copyright © 2018 rht. All rights reserved.
//

class  FireBaseMessageList: NSObject {
    @objc var agentMenu:String?
    @objc var message:String?
    @objc var messageType:String?
    @objc var receiver:String?
    @objc var receiverUid:String?
    @objc var sender:String?
    @objc var senderUid:String?
    @objc var timestamp:NSNumber?
    
    func IsSender() -> Bool {
        return  UserDetail.Instance.id == senderUid! ? true:false
    }
    func date() -> String {
        
        let date = NSDate(timeIntervalSince1970: Double(truncating: timestamp!))
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    func userName() -> String {
        
        debugPrint("SenderName:"+sender!)
         debugPrint("recevierName:"+receiver!)
        debugPrint("SenderName:"+senderUid!)
        debugPrint("recevierudid:"+receiverUid!)
         debugPrint("loginudid:"+UserDetail.Instance.id!)
        var name = ""
        if UserDetail.Instance.id!.elementsEqual(receiverUid!){
            name = sender!
        }else if UserDetail.Instance.id!.elementsEqual(senderUid!){
            name = sender!
        }
        return name;
    }
    func type() -> MessageType {
        
        guard let types = messageType else {
            return MessageType.text
        }
        let messagetype = types.elementsEqual("TEXT")  || types.elementsEqual("Text") ? MessageType.text : MessageType.multiple
        return messagetype;
    }
    func mutipleHeader()->String {
        
        guard let types = messageType else {
            return ""
        }
        let messagetype = types.elementsEqual("TEXT") ? MessageType.text : MessageType.multiple
        
        if (messagetype == MessageType.multiple)
        {
            return message!
        }else{
            return ""
        }
    }
    func textArray() -> [[String : AnyObject]] {
        
        guard let array = agentMenu else {
            return []
        }
         let jsonData = array.data(using: .utf8)!
         var dictionary:[[String : AnyObject]]? = [[:]]
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options:JSONSerialization.ReadingOptions(rawValue: 0))
            dictionary = jsonObject as? [[String : AnyObject]]
            
           // return dictionary!
        }
        catch let error as NSError {
            print("Found an error - \(error)")
        }
        return dictionary!
    }
        
}
