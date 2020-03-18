//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by MCT on 18.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cadLabel: UILabel!
    @IBOutlet weak var chfLabel: UILabel!
    @IBOutlet weak var gbfLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    @IBOutlet weak var tryLabel: UILabel!
    
    let url = URL(string: "http://data.fixer.io/api/latest?access_key=e9977b825b4a26fd981402c2f0c1b86c")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func getRatesButton(_ sender: Any) {
        
        // 1)Request and sessinon
        // 2)Response, data
        // 3)Parsing or JSON Serialization
        
        // 1 Request and session
        let session = URLSession.shared
        
        //Closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert  = UIAlertController(title:"Error", message: error?.localizedDescription, preferredStyle: .alert)
                let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
            }else{
                // 2.
                if data != nil{
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? Dictionary<String,Any> {
                                
                                if let cad = rates["CAD"] as? Double {
                                    self.cadLabel.text = String("CAD: \(cad)")
                                }
                                if let chf = rates["CHF"] as? Double {
                                    self.chfLabel.text = String("CHF: \(chf)")
                                }
                                if let gbp = rates["GBP"] as? Double {
                                    self.gbfLabel.text = String("GBF: \(gbp)")
                                }
                                if let jpy = rates["JPY"] as? Double {
                                    self.jpyLabel.text = String("JPY: \(jpy)")
                                }
                                if let usd = rates["USD"] as? Double {
                                    self.usdLabel.text = String("USD: \(usd)")
                                }
                                if let turkish = rates["TRY"] as? Double {
                                    self.tryLabel.text = String("TRY: \(turkish)")
                                }
                            }
                        }
                    } catch{
                        print("error")
                    }
                    
                }
                
            }
        }
        
        task.resume()
        
        
    }
}

