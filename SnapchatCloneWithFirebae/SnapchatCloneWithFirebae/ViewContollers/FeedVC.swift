//
//  FeedVC.swift
//  SnapchatCloneWithFirebae
//
//  Created by MCT on 30.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Firebase

class FeedVC: UIViewController {
    
    let firestoreDatabase = Firestore.firestore()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        getUserInfo()
    }
    
    
    func getUserInfo(){
        firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshots, error) in
            if error != nil {
                self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
            }else{
                if snapshots?.isEmpty == false && snapshots != nil {
                    for document in snapshots!.documents {
                        if let username = document.get("username") as? String{
                            UserSignletion.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserSignletion.sharedUserInfo.username = username
                        }
                    }
                }
            }
        }
        
    }
    
    
    func makeAlert(inputTitle:String , inputMessage:String){
           let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
           let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(okButton)
           present(alert, animated: true, completion: nil)
       }
}
