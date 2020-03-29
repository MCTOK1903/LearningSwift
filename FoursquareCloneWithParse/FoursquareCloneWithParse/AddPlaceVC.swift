//
//  AddPlaceVC.swift
//  FoursquareCloneWithParse
//
//  Created by MCT on 28.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class AddPlaceVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var placeNameTF: UITextField!
    
    
    @IBOutlet weak var placeTypeTF: UITextField!
    
    @IBOutlet weak var placeAtmosphereTF: UITextField!
    
    @IBOutlet weak var selectImage: UIImageView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImageClicked))
        selectImage.addGestureRecognizer(gestureRecognizer)
    }
    

    @objc func selectImageClicked(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
   
    @IBAction func nextClicked(_ sender: Any) {
        
        if placeNameTF.text != "" && placeTypeTF.text != "" && placeAtmosphereTF.text != "" {
            if let chosenImage = selectImage.image {
                let placeModel = PlaceModel.sharedInstance
                placeModel.placeName = placeNameTF.text!
                placeModel.placeType = placeTypeTF.text!
                placeModel.placeAtmosphere = placeAtmosphereTF.text!
                placeModel.placeImage = chosenImage
            }
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }else{
            //alert
        }
    }
    
}
