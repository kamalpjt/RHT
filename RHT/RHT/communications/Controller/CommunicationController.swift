//
//  CommunicationController.swift
//  RHT
//
//  Created by kamal on 5/15/18.
//  Copyright © 2018 rht. All rights reserved.
//

import UIKit

class CommunicationController: UIViewController,UICollectionViewDelegate,UISearchBarDelegate {
    @IBOutlet weak var txtSearchBar: UISearchBar!
    @IBOutlet weak var lblNoRecord: UILabel!
    @IBOutlet weak var vImageView: UIView!
    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var sbSearchMatter: UISearchBar!
    @IBOutlet weak var cvMatter: UICollectionView!
    var m_MattersDetail:[matters] = []
    var dataSource:MatterDataSource?
    
    @IBOutlet weak var vContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtSearchBar.delegate = self
        vTop.layer.cornerRadius = 10;
        sbSearchMatter.layer.cornerRadius = 10;
        sbSearchMatter.layer.masksToBounds = false
       // ShowAndHideGeneral()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        SetUpCollectionView()
        
    }
    func ShowAndHideGeneral() -> Void{
        
        if UserDetail.Instance.isStaff != 1{
            vTop.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: 0.1/vContainer.frame.height , constant: 0).isActive=true
        }else{
            vTop.heightAnchor.constraint(equalTo: vContainer.heightAnchor, multiplier: 44/vContainer.frame.height , constant: 0).isActive=true
        }
    }
    func SetUpCollectionView()
    {
        let params:[String:String] = ["id":UserDetail.Instance.id!,"userid":UserDetail.Instance.userid!,
                                      "sessionid":"1","page":"1","pagesize":"10","user_type":UserDetail.Instance.user_type!,
                                      "posttype":"general","matterid": ""]
        MatterParsing.instance.getMatterList(url: "/getmatters",withLoader: true, param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! CommunicationModel
                self.m_MattersDetail = model.response.matters
                if(model.response.matters.count>0){
                    self.cvMatter.isHidden = false;
                    self.lblNoRecord.isHidden = true
                    self.dataSource = MatterDataSource()
                    self.dataSource?.m_MatterModel = model.response.matters
                    self.cvMatter.dataSource = self.dataSource
                    self.cvMatter.delegate = self
                    self.cvMatter.reloadData()
                }else{
                    self.cvMatter.isHidden = true;
                    self.lblNoRecord.isHidden = false
                }
            }
        })
    }
    func MatterSearch(text:String) -> Void{
        let params:[String:String] = ["id":UserDetail.Instance.id!,"userid":UserDetail.Instance.userid!,
                                      "sessionid":"1","page":"1","pagesize":"10","user_type":UserDetail.Instance.user_type!,
                                      "posttype":"general","matterid": "" ,"keyword":text]
        MatterParsing.instance.getMatterList(url: "/getmatters",withLoader: true, param: params, resposneBlock: { responsedata , statuscode in
            if(statuscode == 200){
                let model = responsedata as! CommunicationModel
                if(model.response.matters.count>0){
                    self.cvMatter.isHidden = false;
                    self.lblNoRecord.isHidden = true
                    self.dataSource = MatterDataSource()
                    self.dataSource?.m_MatterModel = model.response.matters
                    self.cvMatter.dataSource = self.dataSource
                    self.cvMatter.delegate = self
                    self.cvMatter.reloadData()
                }else{
                    self.cvMatter.isHidden = true;
                    self.lblNoRecord.isHidden = false
                }
            }
        })
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        txtSearchBar.showsCancelButton = true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        MatterSearch(text: searchBar.text!)
        view.endEditing(true)
        txtSearchBar.showsCancelButton = false
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        txtSearchBar.showsCancelButton = false
        txtSearchBar.text = ""
        view.endEditing(true)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(txtSearchBar.text?.count==0){
            SetUpCollectionView()
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        return true;
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func generalAction(_ sender: Any) {
        
        if(UserDetail.Instance.user_type != "customer"){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ClientListController") as! ClientListController ;
            vc.matterType = "general";
            navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunicationDetailController") as! CommunicationDetailController ;
            vc.m_matterType = "general";
            vc.m_matterid = ""
            vc.m_receverid = ""
            navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let modeldata = m_MattersDetail[indexPath.row]
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CommunicationDetailController") as! CommunicationDetailController ;
        vc.m_matterType = "matters";
        vc.m_matterid = modeldata.matterid!
        //vc.m_receverid = modeldata.id!
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
