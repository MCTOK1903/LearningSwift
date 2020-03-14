//
//  ViewController.swift
//  F1Racers
//
//  Created by MCT on 9.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var racerArray = [Racer]()
    var ChosenRacer : Racer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.dataSource = self
        tabelView.delegate = self
        
        let hamilton = Racer(racerName: "Hamilton", racerTeam: "Mercedes", racerOfImage: UIImage(named:"hamilton")!)
        let vettel = Racer(racerName: "Vettel", racerTeam: "Ferrari", racerOfImage: UIImage(named: "vettel")!)
        let ricardo = Racer(racerName: "Ricardo", racerTeam: "Renault", racerOfImage: UIImage(named: "ricardo")!)
        let raikkonen = Racer(racerName: "Raikkonen", racerTeam: "AlfaRomeo", racerOfImage: UIImage(named: "raikkonen")!)
        
        racerArray.append(hamilton)
        racerArray.append(vettel)
        racerArray.append(raikkonen)
        racerArray.append(ricardo)
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = racerArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return racerArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ChosenRacer = racerArray[indexPath.row]
        self.performSegue(withIdentifier: "toRacerDetails", sender:nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRacerDetails"{
            let destinationRacer = segue.destination as! RacersViewController
            destinationRacer.selectedRacer = ChosenRacer
        }
    }
    
    
}

