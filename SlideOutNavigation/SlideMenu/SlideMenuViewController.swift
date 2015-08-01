//
//  LeftViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit

protocol SideMenuDelegate {
    func itemSelected(controllerName: String)
}

class SlideMenuViewController: UIViewController {
  var delegate: SideMenuDelegate?
}