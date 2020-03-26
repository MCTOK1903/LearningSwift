//
//  UploadViewController.swift
//  InstaCloneWithFirebase
//
//  Created by MCT on 25.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var selectImageIV: UIImageView!
    @IBOutlet weak var contentTF: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Recognizer
        
        selectImageIV.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        selectImageIV.addGestureRecognizer(gestureRecognizer)
    }
    
    
    @IBAction func uploadClicked(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolderReferance = storageReferance.child("media")
        let stringUUID = UUID().uuidString
        
        if let data = selectImageIV.image?.jpegData(compressionQuality: 0.5){
            
            let imageReferance = mediaFolderReferance.child("\(stringUUID).jpg")
            imageReferance.putData(data, metadata: nil) { (storageMetaDAta, error) in
                
                if error != nil {
                    self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        
                        if error != nil {
                            self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                        }else{
                            let imageUrl = url?.absoluteString
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference?
                            
                            let firestorePost = ["imageUrl":imageUrl!,
                                                 "postedBy": Auth.auth().currentUser!.email!,
                                                 "postComment": self.contentTF.text!,
                                                 "likes" : 0,
                                                 "date": FieldValue.serverTimestamp()
                                ] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil{
                                    self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                                }else{
                                    
                                    self.selectImageIV.image = UIImage(named: "select.png")
                                    self.contentTF.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                            })
                            
                        }
                    }
                }
            }
        }
        
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImageIV.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    func makeAlert(inputTitle:String,inputMessage:String){
        let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    
}
