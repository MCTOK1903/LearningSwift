//
//  secondViewController.swift
//  SegueApp
//
//  Created by MCT on 7.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    var myName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = myName
    }


}
