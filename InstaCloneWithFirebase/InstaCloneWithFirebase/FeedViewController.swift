//
//  FeedViewController.swift
//  InstaCloneWithFirebase
//
//  Created by MCT on 25.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{


    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FeedCell
        cell.emailLabel.text = "celal"
        cell.commentLabel.text = "sa"
        cell.likeLabel.text = "10"
        cell.imageView?.image = UIImage(named: "select.png")
        return cell
        
    }

}
