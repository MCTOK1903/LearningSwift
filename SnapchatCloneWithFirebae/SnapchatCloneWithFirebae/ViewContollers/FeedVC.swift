//
//  FeedVC.swift
//  SnapchatCloneWithFirebae
//
//  Created by MCT on 30.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    let firestoreDatabase = Firestore.firestore()
    
    var snapArray = [Snap]()
    var chosenSnap : Snap?
    var timeLeft : Int?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getUserInfo()
        getSnapsfromFirebase()
        self.tableView.reloadData()
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
    
    
    func getSnapsfromFirebase(){
        
        firestoreDatabase.collection("Snaps").order(by: "date", descending: true).addSnapshotListener { (snapshots, error) in
            if error != nil {
                self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
            }else{
                if snapshots?.isEmpty == false && snapshots != nil {
                    self.snapArray.removeAll(keepingCapacity: false)
                    for document in snapshots!.documents{
                        
                        let documentId = document.documentID
                        
                        if let username = document.get("snapOwner") as? String {
                            if let imageUrlArray = document.get("imageUrlArray") as? [String] {
                                if let date = document.get("date") as? Timestamp {
                                    
                                    //timeLeft
                                    if let difference = Calendar.current.dateComponents([.hour], from: date.dateValue(), to: Date()).hour {
                                        if difference >= 24 {
                                            self.firestoreDatabase.collection("Snaps").document(documentId).delete { (error) in
                                                if error != nil {
                                                    //makeAlert
                                                }
                                            }
                                            
                                        }
                                        self.timeLeft = 24 - difference
                                        
                                    }
                                    
                                    let snap = Snap(username: username, imageUrlArray: imageUrlArray, date: date.dateValue())
                                    self.snapArray.append(snap)
                                }
                            }
                        }
                    }
                }
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snapArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.usernameLabel.text = self.snapArray[indexPath.row].username
        cell.imageView?.sd_setImage(with: URL(string: self.snapArray[indexPath.row].imageUrlArray[0])) 
        return cell
    }
    
    
    func makeAlert(inputTitle:String , inputMessage:String){
           let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
           let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(okButton)
           present(alert, animated: true, completion: nil)
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenSnap = self.snapArray[indexPath.row]
        performSegue(withIdentifier: "toSnapVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSnapVC" {
            let destination = segue.destination as! SnapVC
            destination.selectedSnap = chosenSnap
            destination.selectedTime = timeLeft
        }
    }
}
