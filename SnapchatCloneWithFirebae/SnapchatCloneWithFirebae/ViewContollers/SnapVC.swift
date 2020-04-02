//
//  SnapVC.swift
//  SnapchatCloneWithFirebae
//
//  Created by MCT on 30.03.2020.
//  Copyright © 2020 MCT. All rights reserved.
//

import UIKit
import ImageSlideshow

class SnapVC: UIViewController {

    @IBOutlet weak var timeleftLabel: UILabel!
    var selectedSnap : Snap?
    var selectedTime : Int?
    
    var inputArray = [KingfisherSource]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let time = selectedTime {
            timeleftLabel.text = "Time Lef: \(time)"
        }
        
        if let snap = selectedSnap {
            for imageUrl in snap.imageUrlArray {
                inputArray.append(KingfisherSource(urlString: imageUrl)!)
            }
        }
        
        
        let imageSlideShow = ImageSlideshow(frame: CGRect(x: 10, y: 10, width: self.view.frame.width*0.95, height: self.view.frame.height*0.90))
        imageSlideShow.backgroundColor = UIColor.white
        
        let pageIndicator = UIPageControl()
        pageIndicator.currentPageIndicatorTintColor = UIColor.black
        pageIndicator.pageIndicatorTintColor = UIColor.lightGray
        imageSlideShow.pageIndicator = pageIndicator
        
        imageSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFit
        imageSlideShow.setImageInputs(inputArray)
        self.view.addSubview(imageSlideShow)
        self.view.bringSubviewToFront(timeleftLabel)
        
        
    }
    

   

}
