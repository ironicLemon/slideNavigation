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
    optional func menuSwipeEnabled(enabled: Bool)
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