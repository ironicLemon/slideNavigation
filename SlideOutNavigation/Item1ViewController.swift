//
//  Item1ViewController.swift
//  SlideOutNavigation
//
//  Created by zeus on 30/07/2015.
//  Copyright © 2015 James Frost. All rights reserved.
//

import Foundation
import UIKit

class Item1ViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let slideNavController = navigationController as? SlideMenuUINavigationController
        slideNavController?.slideNavDelegate?.menuSwipeEnabled?(true)
    }
    
}