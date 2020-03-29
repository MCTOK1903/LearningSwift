//
//  DetailsVC.swift
//  FoursquareCloneWithParse
//
//  Created by MCT on 28.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var placeAtmosphere: UILabel!
    
    var chosenPlaceId = ""
    var chosenlatitude = Double()
    var chosenLongitude = Double()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getDataFromParse()
        
    }
    
    func getDataFromParse(){
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { (objects, error) in
            if error != nil {
                //alert
            }else{
                if objects != nil{
                    if objects!.count > 0{
                        let chosenPlaceObject = objects![0]
                        
                        if let placeName = chosenPlaceObject.object(forKey: "name") as? String{
                            self.placeNameLabel.text = placeName
                        }
                        if let placeType = chosenPlaceObject.object(forKey: "type") as? String{
                            self.placeTypeLabel.text = placeType
                        }
                        if let placeAtmosphere = chosenPlaceObject.object(forKey: "atmosphere") as? String{
                            self.placeAtmosphere.text = placeAtmosphere
                        }
                        if let placeLatitude = chosenPlaceObject.object(forKey: "latitude") as? String{
                            if let placeLatitudeDouble = Double(placeLatitude){
                                self.chosenlatitude = placeLatitudeDouble
                            }
                        }
                        if let placeLongitude = chosenPlaceObject.object(forKey: "longitude") as? String{
                            if let placeLongitudeDouble = Double(placeLongitude){
                                self.chosenLongitude = placeLongitudeDouble
                            }
                        }
                        
                        if let imageData = chosenPlaceObject.object(forKey: "image") as? PFFileObject{
                            imageData.getDataInBackground { (data, error) in
                                if error != nil {
                                    //alert
                                }else{
                                    if data != nil{
                                        self.imageView.image = UIImage(data: data!)
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
    }
    



}
