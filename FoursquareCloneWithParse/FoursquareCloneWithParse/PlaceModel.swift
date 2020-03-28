//
//  PlaceModel.swift
//  FoursquareCloneWithParse
//
//  Created by MCT on 28.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

// this model was created to move place info from addPlaceVC file to MapVC file
//Singleton desing pattern

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    
    private init(){
        
    }
}
