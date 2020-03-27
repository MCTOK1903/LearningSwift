//
//  PlacesViewController.swift
//  FoursquareCloneWithParse
//
//  Created by MCT on 27.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import Parse

class PlacesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "LogOut", style: .done, target: self, action: #selector(logOutButtonClicked))
        
    }
    
    @objc func addButtonClicked(){
        //segue
    }
    
    @objc func logOutButtonClicked(){
        
        PFUser.logOutInBackground { (error) in
            if error != nil {
                self.makeAlert(inputTitle: "Error!", inputMessage: error?.localizedDescription ?? "Error")
            }else{
                self.performSegue(withIdentifier: "toSignUpVC", sender: nil)
            }
        }
        
        
        
    }
    
    func makeAlert(inputTitle:String,inputMessage:String){
        let alert = UIAlertController(title: inputTitle, message: inputMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    


}
