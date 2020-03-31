//
//  UploadVC.swift
//  SnapchatCloneWithFirebae
//
//  Created by MCT on 30.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Firebase

class UploadVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadImageView.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        uploadImageView.addGestureRecognizer(imageGesture)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.originalImage] as? UIImage
        dismiss(animated: true, completion: nil)
    }
    

    
     @IBAction func uploadClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolderReferance = storageReferance.child("media")
        let uuidString = UUID().uuidString
        
        if let data = uploadImageView.image?.jpegData(compressionQuality: 0.5) {
            
            let imageReferance = mediaFolderReferance.child("\(uuidString).jpg")
            
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                }else {
                    imageReferance.downloadURL { (url, error) in
                        if error != nil {
                            self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                        }else{
                            let imageUrl = url?.absoluteString
                            
                            
                            //firestore
                            
                            let firestore = Firestore.firestore()
                            
                            firestore.collection("Snaps").whereField("snapOwner", isEqualTo: UserSignletion.sharedUserInfo.username).getDocuments { (snapshots, error) in
                                if error != nil {
                                    self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                                }else{
                                    if snapshots?.isEmpty == false && snapshots != nil{
                                        for document in snapshots!.documents{
                                            
                                            let documnetId = document.documentID
                                            
                                            if var imageUrlArray = document.get("imageUrlArray") as? [String]{
                                                    imageUrlArray.append(imageUrl!)
                                                
                                                let additionalDictionary = ["imageUrlArray" : imageUrlArray] as [String : Any]
                                                firestore.collection("Snaps").document(documnetId).setData(additionalDictionary, merge: true) { (error) in
                                                    if error != nil {
                                                        self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                                                    }else{
                                                        self.tabBarController?.selectedIndex = 0
                                                        self.uploadImageView.image = UIImage(named: "select.png")
                                                    }
                                                }
                                            }
                                            
                                            
                                        }
                                    }else{
                                        let snapDictionary = ["imageUrlArray": [imageUrl!] , "snapOwner": UserSignletion.sharedUserInfo.username, "date": FieldValue.serverTimestamp()] as [String : Any]
                                                                
                                        firestore.collection("Snaps").addDocument(data: snapDictionary) { (error) in
                                            if error != nil {
                                                self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                                                }else{
                                                    self.tabBarController?.selectedIndex = 0
                                                    self.uploadImageView.image = UIImage(named: "select.png")
                                                }
                                        }
                                    }
                                }
                            }
                            
                            
                        
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
