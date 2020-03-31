//
//  Settings.swift
//  SnapchatCloneWithFirebae
//
//  Created by MCT on 30.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Firebase

class Settings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutClicked(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toSignInVC", sender: nil)
        }catch{
            print("errror!")
        }
        
    }
    
   

}
