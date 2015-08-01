//
//  CenterViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

class CatViewController: UIViewController {
  
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var creatorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        slideMenuSwipe(true)
    }
  
    // TODO can make this a UIViewController extension...
    @IBAction func menuTapped(sender: UIBarButtonItem) {
        toggleLeftSlideMenu()
    }
    
    @IBAction func rightMenuTapped(sender: UIBarButtonItem) {
        toggleRightSlideMenu()
    }
}