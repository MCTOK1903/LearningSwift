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
    var mortyArray = [UIImageView]()
    var score = 0
    var highScore = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        
        if let newScore = storedHighScore as? Int{
            highScore = newScore
            highScoreLabel.text = "HighScore: \(highScore)"
        }
        
        rick1.isUserInteractionEnabled = true
        rick2.isUserInteractionEnabled = true
        rick3.isUserInteractionEnabled = true
        rick4.isUserInteractionEnabled = true
        rick5.isUserInteractionEnabled = true
        rick6.isUserInteractionEnabled = true
        rick7.isUserInteractionEnabled = true
        rick8.isUserInteractionEnabled = true
        rick9.isUserInteractionEnabled = true
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        rick1.addGestureRecognizer(recognizer1)
        rick2.addGestureRecognizer(recognizer2)
        rick3.addGestureRecognizer(recognizer3)
        rick4.addGestureRecognizer(recognizer4)
        rick5.addGestureRecognizer(recognizer5)
        rick6.addGestureRecognizer(recognizer6)
        rick7.addGestureRecognizer(recognizer7)
        rick8.addGestureRecognizer(recognizer8)
        rick9.addGestureRecognizer(recognizer9)
        
        mortyArray = [rick1,rick2,rick3,rick4,rick5,rick6,rick7,rick8,rick9]
        counter = 10
        timerLabel.text = "Time:\(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(setTimer), userInfo: nil, repeats: true)
        
        timerforImage = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(setImageVisible), userInfo: nil , repeats: true)
        
    }
    
    @objc func increaseScore(){
        score += 1
        userScoreLabel.text = String("Score: \(score)")
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
            timerforImage.invalidate()
            timerLabel.text = "Time's Over"
            createAlert()
            if score > highScore{
                highScore = score
                highScoreLabel.text = String("HidhScore: \(highScore)")
                UserDefaults.standard.set(highScore, forKey: "highScore")
            }
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
            self.score = 0
            self.userScoreLabel.text = String("Score:\(self.score)")
            self.counter = 10
            self.timerLabel.text = String(self.counter)
            
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.setTimer), userInfo: nil, repeats: true)
            
            self.timerforImage = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.setImageVisible), userInfo: nil , repeats: true)
            
        }
        alert.addAction(replayButton)
        self.present(alert, animated: true, completion: nil)
    }

}

