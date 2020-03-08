//
//  ViewController.swift
//  CatchRick
//
//  Created by MCT on 8.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var userScoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    @IBOutlet weak var rick1: UIImageView!
    @IBOutlet weak var rick2: UIImageView!
    @IBOutlet weak var rick3: UIImageView!
    @IBOutlet weak var rick4: UIImageView!
    @IBOutlet weak var rick5: UIImageView!
    @IBOutlet weak var rick6: UIImageView!
    @IBOutlet weak var rick7: UIImageView!
    @IBOutlet weak var rick8: UIImageView!
    @IBOutlet weak var rick9: UIImageView!
    
    var visibleUIImage : UIImageView!
    var randomNumber : Int = 0
    var timer = Timer()
    var timerforImage = Timer()
    var counter = 0
    var visibleCheck = true
    var mortyArray = [UIImageView]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        mortyArray = [rick1,rick2,rick3,rick4,rick5,rick6,rick7,rick8,rick9]
        
        counter = 10
        timerLabel.text = "Time:\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
        
        timerforImage = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setImageVisible), userInfo: nil , repeats: true)
        
    }

    @objc func setImageVisible(){
       
        for morty in mortyArray{
            morty.isHidden = true
        }
        
        let random = Int(arc4random_uniform(UInt32(mortyArray.count-1)))
        mortyArray[random].isHidden = false
        
    }
    
    @objc func setTimer(){
        counter -= 1
        timerLabel.text = "Time:\(counter)"

        if counter == 0 {
            timer.invalidate()
            timerLabel.text = "Time's Over"
            createAlert()
        }
    }
    
    func createAlert(){
        let alert = UIAlertController(title: "Time's Over", message: "Do you want play again?", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                print("OKButton")
        }
        alert.addAction(okButton)
        let replayButton = UIAlertAction(title: "Replay", style: .default) { (UIAlertAction) in
                print("ReplayButton")
        }
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }

}

