//
//  ViewController.swift
//  InstaCloneWithFirebase
//
//  Created by MCT on 25.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func singInClicked(_ sender: Any) {
        
        if emailTextField.text! != "" && passwordTextField.text! != "" {
            
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authDataResult, error) in
                if error != nil {
                    self.makeAlert(inputTitle: "Error", inputMessage: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(inputTitle: "Error", inputMessage: "Email/Password?")
        }
        
    }
    
    @IBAction func singUpClicked(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" {
            
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (authDataResult, error) in
                
                if error != nil {
                    self.makeAlert(inputTitle: "Error", inputMessage: error?.localizedDescription ?? "Errpr")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        }else{
            self.makeAlert(inputTitle: "Error!", inputMessage: "Email/Password?")
        }
        
    }
    
    func makeAlert(inputTitle:String, inputMessage:String){
        let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}

