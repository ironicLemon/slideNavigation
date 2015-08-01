//
//  NextViewController.swift
//  SlideOutNavigation
//
//  Created by mobileadmin on 29/07/2015.
//  Copyright (c) 2015 James Frost. All rights reserved.
//

import Foundation
import UIKit

class NextViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let slideNavController = navigationController as? SlideMenuUINavigationController
        slideNavController?.slideNavDelegate?.menuSwipeEnabled?(false)
    }
    
}