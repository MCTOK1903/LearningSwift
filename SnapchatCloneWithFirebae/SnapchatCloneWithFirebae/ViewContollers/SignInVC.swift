//
//  ViewController.swift
//  SnapchatCloneWithFirebae
//
//  Created by MCT on 29.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextFied: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
     
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signInClicked(_ sender: Any) {
        if emailTextFied.text != "" && passwordTextField.text != "" {
            
            Auth.auth().signIn(withEmail: emailTextFied.text!, password: passwordTextField.text!) { (dataResult, error) in
                if error != nil {
                    self.makeAlert(inputTitle: "Error", inputMessage: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
            self.makeAlert(inputTitle: "Error!", inputMessage: "Email/passwpord?")
        }
        
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        if emailTextFied.text != "" && usernameTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().createUser(withEmail: emailTextFied.text!, password: passwordTextField.text!) { (authData, error) in
                if error != nil {
                    self.makeAlert(inputTitle: "Error", inputMessage: error?.localizedDescription ?? "ERror")
                }else{
                    
                    let fireStore = Firestore.firestore()
                    
                    let userDictionary = ["email": self.emailTextFied.text!,"username": self.usernameTextField.text!] as [String : Any]
                    
                    fireStore.collection("UserInfo").addDocument(data: userDictionary) { (error) in
                        self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                    }
                    
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
            self.makeAlert(inputTitle: "Error!", inputMessage: "Email/username/passwpord?")
        }
    }
    
    func makeAlert(inputTitle:String , inputMessage:String){
        let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

