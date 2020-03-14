//
//  ViewController.swift
//  LandMarkBook
//
//  Created by MCT on 9.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var landMarkNames = [String]()
    var landMarkImages = [UIImage]()
    
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //landMArkBookData
        landMarkNames.append("eiffelTower")
        landMarkNames.append("empireStateBuild")
        landMarkNames.append("trojanHorse")
        
        landMarkImages.append(UIImage(named:"eiffelTower.jpeg")!)
        landMarkImages.append(UIImage(named:"empireStateBuild.jpg")!)
        landMarkImages.append(UIImage(named: "trojanHorse.jpg")!)
        
        navigationItem.title = "Land Mark"

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = landMarkNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return landMarkNames.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            landMarkNames.remove(at: indexPath.row)
            landMarkImages.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toImageViewController", sender: nil)
        selectedIndex = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toImageViewController"{
            let destinationImage = segue.destination as! ImageViewController
            destinationImage.selectedLanMarkImage = landMarkImages[selectedIndex]
            
            let destinationLabel = segue.destination as! ImageViewController
            destinationLabel.selectedLandMarkName = landMarkNames[selectedIndex]
        }
    }
    
    
}

