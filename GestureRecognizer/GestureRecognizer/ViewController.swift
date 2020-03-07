//
//  ViewController.swift
//  GestureRecognizer
//
//  Created by MCT on 7.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var rAndMimageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    var isChange = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rAndMimageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        
        rAndMimageView.addGestureRecognizer(gestureRecognizer)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func changePic(){
        
        if isChange == false{
            rAndMimageView.image = UIImage(named: "rickandMorty")
            textLabel.text = "rickAndMorty1"
            isChange=true
        }else{
            rAndMimageView.image = UIImage(named: "rickAndMorty2")
            textLabel.text = "rickAndMorty2"
            isChange=false
        }
    }
}

