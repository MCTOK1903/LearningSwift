//
//  ViewController.swift
//  FoursquareCloneWithParse
//
//  Created by MCT on 27.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Parse


class SignUpVC: UIViewController {

    @IBOutlet weak var usernameLabel: UITextField!
    
    @IBOutlet weak var passwordLabel: UITextField!
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        
    }

    @IBAction func signInClicked(_ sender: Any) {
        
        if usernameLabel.text != "" && passwordLabel.text != "" {
            
            PFUser.logInWithUsername(inBackground: usernameLabel.text!, password: passwordLabel.text!) { (user, error) in
                if error != nil{
                    self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                }else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
            
        }else{
            self.makeAlert(inputTitle: "Error", inputMessage: "Username/Password?")
        }
        
        
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
      
        if usernameLabel.text != "" && passwordLabel.text != "" {
            
            let user = PFUser()
                  
            user.username = usernameLabel.text!
            user.password = passwordLabel.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil{
                    self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
                }else{
                    print(success)
                }
            }
        }else{
            makeAlert(inputTitle: "Error!", inputMessage: "Username/Password?")
        }
        
    }
    
    func makeAlert(inputTitle:String,inputMessage:String){
        let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
    
}

