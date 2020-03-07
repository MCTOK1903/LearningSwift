//
//  ViewController.swift
//  MyFirstApp
//
//  Created by MCT on 4.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func buttonClicked(_ sender: Any) {
        imageView.image = UIImage.init(named: "rickAndMorty2");
    }
}

