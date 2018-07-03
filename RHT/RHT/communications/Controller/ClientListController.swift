//
//  ClientListController.swift
//  RHT
//
//  Created by kamal on 01/07/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class ClientListController: UIViewController,UICollectionViewDelegate,UISearchBarDelegate,GetIDDelegate {
    
    @IBOutlet weak var lblNoRecordFound: UILabel!
    var dataSource:ClientDatatSource?
    @IBOutlet weak var cvClinetList: UICollectionView!
    @IBOutlet weak var sbSearchBar: UISearchBar!
    var matterType:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        sbSearchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetUpCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func SetUpCollectionView()
    {
        let params:[String:String] = ["id":UserDetail.Instance.id!,"userid":UserDetail.Instance.userid!,
                                      "sessionid":"1","page":"1","pagesize":"10","user_type":UserDetail.Instance.user_type!]
        MatterParsing.instance.getClientList(url: "/getclientlist", param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! ClientModel
                if(model.response.userlist.count>0){
                    self.cvClinetList.isHidden = false;
                    self.lblNoRecordFound.isHidden = true
                    self.dataSource = ClientDatatSource.init(model: model,delegate: self)
                    self.cvClinetList.dataSource = self.dataSource
                    self.cvClinetList.delegate = self.dataSource
                    self.cvClinetList.reloadData()
                }else{
                    self.cvClinetList.isHidden = true;
                    self.lblNoRecordFound.isHidden = false
                }
            }
        })
    }
    func MatterSearch(text:String) -> Void{
        let params:[String:String] = ["id":UserDetail.Instance.id!,"userid":UserDetail.Instance.userid!,
                            "sessionid":"1","page":"1","pagesize":"10","user_type":UserDetail.Instance.user_type!,"keyword":text]
        MatterParsing.instance.getClientList(url: "/getclientlist", param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! ClientModel
                if(model.response.userlist.count>0){
                    self.cvClinetList.isHidden = false;
                    self.lblNoRecordFound.isHidden = true
                    self.dataSource = ClientDatatSource.init(model: model,delegate: self)
                    self.cvClinetList.dataSource = self.dataSource
                    self.cvClinetList.delegate = self.dataSource
                    self.cvClinetList.reloadData()
                }else{
                    self.cvClinetList.isHidden = true;
                    self.lblNoRecordFound.isHidden = false
                }
            }
        })
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        sbSearchBar.showsCancelButton = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        MatterSearch(text: searchBar.text!)
        view.endEditing(true)
        sbSearchBar.showsCancelButton = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        sbSearchBar.showsCancelButton = false
        sbSearchBar.text = ""
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(sbSearchBar.text?.count==0){
            SetUpCollectionView()
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true;
    }
    func GetSelectedRecevierId(receverid: String) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunicationDetailController") as! CommunicationDetailController ;
        vc.m_matterType = matterType!
        vc.m_receverid = receverid
        navigationController?.pushViewController(vc, animated: true)
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
