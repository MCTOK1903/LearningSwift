//
//  FeedViewController.swift
//  InstaCloneWithFirebase
//
//  Created by MCT on 25.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{


    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var userLikesArray = [Int]()
    var userImageArray = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getDataFromFirestore()
    }
    
    
    func getDataFromFirestore(){
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").addSnapshotListener { (snapshot, error) in
            
            if error != nil{
                print(error?.localizedDescription as Any)
            }else{
                if snapshot?.isEmpty != true{
                    
                    self.userImageArray.removeAll(keepingCapacity: false)
                    self.userLikesArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        
                        if let postedBy = document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let userComment = document.get("postComment") as? String{
                            self.userCommentArray.append(userComment)
                        }
                        if let likes = document.get("likes") as? Int {
                            self.userLikesArray.append(likes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.userImageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = userEmailArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.likeLabel.text = String(userLikesArray[indexPath.row])
        return cell
    }

}
