//
//  EntrySummaryViewController.swift
//  Soybean Tracker
//
//  Created by tom stimes on 11/7/16.
//  Copyright © 2016 iastate.mechanics. All rights reserved.
//

import UIKit

class EntrySummaryViewController: ChildViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var detailsLabel: UILabel!
    
    weak var createViewController: CreateEntryViewController?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        super.index = 4
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let parent = createViewController {
            imageView.image = parent.image
            
            //REPEATED CODE!
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            formatter.timeStyle = .short
            
            let dateString = formatter.string(from: parent.data.date!)
            
            detailsLabel.text = dateString
            
            if let disease = parent.data.disease {
                detailsLabel.text = detailsLabel.text! + "\r\n Infected with " + disease + " (" + String(parent.data.severity!) + "%)"
            }
            
            if let long = parent.data.longitude {
                detailsLabel.text = detailsLabel.text! + "\r\n Located at (" + String(parent.data.latitude!) + ", " + String(long) + ")"
            }
            
        }
    }
    
    @IBAction func backOnClick(_ sender: UIButton) {
        createViewController?.transitionBackFrom(pageIndex: index)
    }
    
    @IBAction func submitOnClick(_ sender: UIButton) {
        createViewController!.submit()
    }

}
