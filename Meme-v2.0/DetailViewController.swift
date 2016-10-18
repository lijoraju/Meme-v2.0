//
//  DetailViewController.swift
//  Meme-v2.0
//
//  Created by LIJO RAJU on 17/10/16.
//  Copyright © 2016 LIJORAJU. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController:UIViewController {
    
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme:UIImage!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeImage.contentMode = .scaleAspectFit
        memeImage.image = meme //Show Meme selected
        self.tabBarController?.tabBar.isHidden = true //Hides tabBar
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
}
