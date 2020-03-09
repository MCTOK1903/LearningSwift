//
//  ImageViewController.swift
//  LandMarkBook
//
//  Created by MCT on 9.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var selectedLandMarkName = ""
    var selectedLanMarkImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = selectedLanMarkImage
        textLabel.text = selectedLandMarkName
    }

}
