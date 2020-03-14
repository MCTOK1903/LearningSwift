//
//  Racer.swift
//  F1Racers
//
//  Created by MCT on 9.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import Foundation
import UIKit

class Racer {
    
    var name : String
    var racerOfTeam : String
    var racerImage :UIImage
    
    init(racerName: String, racerTeam: String, racerOfImage:UIImage) {
        name = racerName
        racerOfTeam = racerTeam
        racerImage = racerOfImage
    }
    
}
