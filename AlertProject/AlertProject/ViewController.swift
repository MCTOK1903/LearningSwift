//
//  ViewController.swift
//  AlertProject
//
//  Created by MCT on 7.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userpasswordTextField: UITextField!
    @IBOutlet weak var userpasswordAgainTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func singUpButton(_ sender: Any) {
        
        if usernameTextField.text! == "" {
            alertFunc(title: "Error", message: "Username is empty, Pleas enter Username")
        }else if userpasswordTextField.text! != userpasswordAgainTextField.text! || userpasswordAgainTextField.text! == "" || userpasswordAgainTextField.text! == ""{
            alertFunc(title: "Error", message: "Password is not same")
        }else{
            alertFunc(title: "Success", message: "Sing Up Success")
        }
    }
    
    func alertFunc(title: String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okeyButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okeyButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

