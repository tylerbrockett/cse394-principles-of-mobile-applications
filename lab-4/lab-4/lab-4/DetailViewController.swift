//
//  DetailViewController.swift
//  lab-4
//
//  Created by Tyler Brockett on 2/16/16.
//  Copyright © 2016 Tyler Brockett. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pictureIV: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var location:Location = Location(name: "", image: "", description: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        nameLabel.text = location.getName()
        descriptionLabel.text = location.getDescription()
        let image = UIImage(named: location.getImage())
        pictureIV.image = image
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

