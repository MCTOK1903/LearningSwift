//
//  ViewController.swift
//  ObjectWithCode
//
//  Created by MCT on 6.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let myLabel = UILabel()
    let myButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        myLabel.text = "just text bro"
        myLabel.textAlignment = .center
        myLabel.frame = CGRect(x: width * 0.5-150, y: height*0.5-75, width: 300, height: 100)
        view.addSubview(myLabel)
        
        myButton.setTitle("u are change everything, just touch", for:.normal)
        myButton.setTitleColor(UIColor.blue, for:.normal)
        myButton.frame = CGRect(x: width * 0.5-200, y: height * 0.7-100 , width: 400, height: 200)
        myButton.addTarget(self, action: #selector(myAction), for: UIControl.Event.touchUpInside)
        view.addSubview(myButton)
    }
    
    @objc func myAction(){
        myLabel.text =  "just joke, gfus"
    }
    


}

