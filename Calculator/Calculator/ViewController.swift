//
//  ViewController.swift
//  Calculator
//
//  Created by MCT on 5.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func divisionButton(_ sender: Any) {
        if let myNumber = Int(textField.text!) , let myNumber2 = Int(textField2.text!){
                   resultLabel.text = String(myNumber/myNumber2);
        }else{
            resultLabel.text = "wrong variable"
        }
    }
    
    @IBAction func multiplicationButton(_ sender: Any) {
        if let myNumber = Int(textField.text!) , let myNumber2 = Int(textField2.text!){
                   resultLabel.text = String(myNumber*myNumber2);
        }else{
            resultLabel.text = "wrong variable"
        }
    }
    
    @IBAction func subtractionButton(_ sender: Any) {
        if let myNumber = Int(textField.text!) , let myNumber2 = Int(textField2.text!){
                   resultLabel.text = String(myNumber-myNumber2);
        }else{
            resultLabel.text = "wrong variable"
        }
    }
        
    @IBAction func additionButton(_ sender: Any) {
        if let myNumber = Int(textField.text!) , let myNumber2 = Int(textField2.text!){
                   resultLabel.text = String(myNumber+myNumber2);
        }else{
            resultLabel.text = "wrong variable"
        }
    }
}
