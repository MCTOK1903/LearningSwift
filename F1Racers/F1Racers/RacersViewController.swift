//
//  RacersViewController.swift
//  F1Racers
//
//  Created by MCT on 9.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class RacersViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var racerName: UILabel!
    @IBOutlet weak var racerOfTeam: UILabel!
    
    var selectedRacer : Racer?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        racerName.text = selectedRacer?.name
        racerOfTeam.text = selectedRacer?.racerOfTeam
        imageView.image = selectedRacer?.racerImage
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
