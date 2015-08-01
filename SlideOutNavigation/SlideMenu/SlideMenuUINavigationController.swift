//
//  SlideMenuUINavigationController.swift
//  SlideOutNavigation
//
//  Created by mobileadmin on 29/07/2015.
//  Copyright (c) 2015 James Frost. All rights reserved.
//

import Foundation
import UIKit

@objc
protocol SlideNavigationDelegate {
    optional func toggleLeftPanel()
    optional func toggleRightPanel()
    optional func collapseSidePanels()
    optional func menuSwipe(enabled: Bool)
}

class SlideMenuUINavigationController : UINavigationController, SideMenuDelegate {

    var slideNavDelegate: SlideNavigationDelegate?

    func itemSelected(controllerName: String) {
        slideNavDelegate?.collapseSidePanels?()        
        popToRootViewControllerAnimated(false)
        let viewController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier(controllerName)
        viewControllers = [viewController];
    }
}

extension UIViewController {
    func toggleLeftSlideMenu() {
        let slideNavController = navigationController as? SlideMenuUINavigationController
        slideNavController?.slideNavDelegate?.toggleLeftPanel?()
    }
    
    func toggleRightSlideMenu() {
        let slideNavController = navigationController as? SlideMenuUINavigationController
        slideNavController?.slideNavDelegate?.toggleRightPanel?()
    }
    
    func slideMenuSwipe(enabled: Bool) {
        let slideNavController = navigationController as? SlideMenuUINavigationController
        slideNavController?.slideNavDelegate?.menuSwipe?(enabled)
    }
}