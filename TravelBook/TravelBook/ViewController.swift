//
//  ViewController.swift
//  TravelBook
//
//  Created by MCT on 14.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var placeNameTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var choosenLatitude = Double()
    var choosenLongtude = Double()
    var selectedTitle = ""
    var selectedTitleId : UUID?
    
    var annotationTitle = ""
    var annotationSubTitle = ""
    var annotationLatitude = Double()
    var annotationLongtude = Double()
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2.5
        mapView.addGestureRecognizer(gestureRecognizer)
        
        if selectedTitle != ""{
            //core data
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
            let idString = selectedTitleId?.uuidString
            request.predicate = NSPredicate(format: "id = %@", idString!)
            
            do{
                let results = try context.fetch(request)
                
                if results.count > 0 {
                    
                    for result in results as! [NSManagedObject] {
                        
                        if let title = result.value(forKey: "title") as? String{
                            annotationTitle  = title
                            
                            if let subTitle = result.value(forKey: "subTitle") as? String{
                                annotationSubTitle = subTitle
                                
                                if let longtude = result.value(forKey: "longtude") as? Double{
                                    annotationLongtude = longtude
                                    
                                    if let latitude = result.value(forKey: "latitude") as? Double{
                                        annotationLatitude = latitude
                                        
                                        let anotation = MKPointAnnotation()
                                        anotation.title = annotationTitle
                                        anotation.subtitle = annotationSubTitle
                                        let coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongtude)
                                        anotation.coordinate = coordinate
                                        mapView.addAnnotation(anotation)
                                        placeNameTF.text = annotationTitle
                                        descriptionTF.text = annotationSubTitle
                                        
                                        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                                        let region = MKCoordinateRegion(center: coordinate, span: span)
                                        mapView.setRegion(region, animated: true)
                                        
                                        saveButton.isHidden = true
                                    }
                                }
                            }
                        }
                        
                    }
                    
                }
                
            }catch{
                print("error")
               
            }
            
            
            
        }else{
            // add new data
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if selectedTitle == "" {
            let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let region = MKCoordinateRegion(center: location, span: span)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManagerDidResumeLocationUpdates(_ manager: CLLocationManager) {
        placeNameTF.text = ""
    }
    
    @objc func chooseLocation(gestureRecognizer:UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began{
            let touchedPoint = gestureRecognizer.location(in: self.mapView)
            let touchCoordinate = mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
            
            choosenLatitude = touchCoordinate.latitude
            choosenLongtude = touchCoordinate.longitude
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchCoordinate
            annotation.title = placeNameTF.text
            annotation.subtitle = descriptionTF.text
            self.mapView.addAnnotation(annotation)
            saveButton.isEnabled = true
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(placeNameTF.text, forKey: "title")
        newPlace.setValue(descriptionTF.text, forKey: "subTitle")
        newPlace.setValue(choosenLongtude, forKey: "longtude")
        newPlace.setValue(choosenLatitude, forKey: "latitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do{
            try context.save()
            print("success")
        }catch{
            print("error")
        }
        NotificationCenter.default.post(name: NSNotification.Name.init("newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
    }
    
    
    
}

