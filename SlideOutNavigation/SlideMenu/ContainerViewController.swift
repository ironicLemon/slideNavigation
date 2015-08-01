//
//  ContainerViewController.swift
//  SlideOutNavigation
//
//  Created by James Frost on 03/08/2014.
//  Copyright (c) 2014 James Frost. All rights reserved.
//

import UIKit
import QuartzCore

enum SlideOutState {
  case BothCollapsed
  case LeftPanelExpanded
  case RightPanelExpanded
}

class ContainerViewController: UIViewController {
  
  var centerViewController: SlideMenuUINavigationController!
  var panGestureRecognizer : UIPanGestureRecognizer!
  
  var currentState: SlideOutState = .BothCollapsed {
    didSet {
      let shouldShowShadow = currentState != .BothCollapsed
      showShadowForCenterViewController(shouldShowShadow)
    }
  }
  
  var leftViewController: SlideMenuViewController?
  var rightViewController: SlideMenuViewController?

  let centerPanelExpandedOffset: CGFloat = 60
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    centerViewController = UIStoryboard.centerViewController()
    centerViewController.slideNavDelegate = self

    view.addSubview(centerViewController.view)
    addChildViewController(centerViewController)
    
    centerViewController.didMoveToParentViewController(self)
    
    panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
    centerViewController.view.addGestureRecognizer(panGestureRecognizer)
  }
  
}

extension ContainerViewController: SlideNavigationDelegate {

    func menuSwipe(enabled: Bool) {
        panGestureRecognizer?.enabled = enabled;
    }
    
  func toggleLeftPanel() {
    let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
    
    if notAlreadyExpanded {
      addLeftPanelViewController()
    }
    
    animateLeftPanel(shouldExpand: notAlreadyExpanded)
  }
  
  func toggleRightPanel() {
    let notAlreadyExpanded = (currentState != .RightPanelExpanded)
    
    if notAlreadyExpanded {
      addRightPanelViewController()
    }
    
    animateRightPanel(shouldExpand: notAlreadyExpanded)
  }
  
  func collapseSidePanels() {
    switch (currentState) {
    case .RightPanelExpanded:
      toggleRightPanel()
    case .LeftPanelExpanded:
      toggleLeftPanel()
    default:
      break
    }
  }
  
  func addLeftPanelViewController() {
    if (leftViewController == nil) {
      leftViewController = UIStoryboard.leftViewController()
      addChildSidePanelController(leftViewController!)
    }
  }
  
  func addChildSidePanelController(sidePanelController: SlideMenuViewController) {
    sidePanelController.delegate = centerViewController
    
    view.insertSubview(sidePanelController.view, atIndex: 0)
    
    addChildViewController(sidePanelController)
    sidePanelController.didMoveToParentViewController(self)
  }
  
  func addRightPanelViewController() {
    if (rightViewController == nil) {
      rightViewController = UIStoryboard.rightViewController()
      addChildSidePanelController(rightViewController!)
    }
  }
  
  func animateLeftPanel(shouldExpand shouldExpand: Bool) {
    if (shouldExpand) {
      currentState = .LeftPanelExpanded
      
      animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerViewController.view.frame) - centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { finished in
        self.currentState = .BothCollapsed
        
        self.leftViewController!.view.removeFromSuperview()
        self.leftViewController = nil;
      }
    }
  }
  
  func animateCenterPanelXPosition(targetPosition targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
    UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
      self.centerViewController.view.frame.origin.x = targetPosition
      }, completion: completion)
  }
  
  func animateRightPanel(shouldExpand shouldExpand: Bool) {
    if (shouldExpand) {
      currentState = .RightPanelExpanded
      
      animateCenterPanelXPosition(targetPosition: -CGRectGetWidth(centerViewController.view.frame) + centerPanelExpandedOffset)
    } else {
      animateCenterPanelXPosition(targetPosition: 0) { _ in
        self.currentState = .BothCollapsed
        
        self.rightViewController!.view.removeFromSuperview()
        self.rightViewController = nil;
      }
    }
  }
  
  func showShadowForCenterViewController(shouldShowShadow: Bool) {
    if (shouldShowShadow) {
      centerViewController.view.layer.shadowOpacity = 0.8
    } else {
      centerViewController.view.layer.shadowOpacity = 0.0
    }
  }
  
}

extension ContainerViewController: UIGestureRecognizerDelegate {

  func handlePanGesture(recognizer: UIPanGestureRecognizer) {
    let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
    
    switch(recognizer.state) {
    case .Began:
      if (currentState == .BothCollapsed) {
        if (gestureIsDraggingFromLeftToRight) {
          addLeftPanelViewController()
        } else {
          addRightPanelViewController()
        }
        
        showShadowForCenterViewController(true)
      }
    case .Changed:
      recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
      recognizer.setTranslation(CGPointZero, inView: view)
    case .Ended:
      if (leftViewController != nil) {
        // animate the side panel open or closed based on whether the view has moved more or less than halfway
        let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
        animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
      } else if (rightViewController != nil) {
        let hasMovedGreaterThanHalfway = recognizer.view!.center.x < 0
        animateRightPanel(shouldExpand: hasMovedGreaterThanHalfway)
      }
    default:
      break
    }
  }
}

extension UIStoryboard {
  class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
}
  
private extension UIStoryboard {
  class func leftViewController() -> SlideMenuViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("LeftMenuViewController") as? SlideMenuViewController
  }
  
  class func rightViewController() -> SlideMenuViewController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("RightMenuViewController") as? SlideMenuViewController
  }
  
  class func centerViewController() -> SlideMenuUINavigationController? {
    return mainStoryboard().instantiateViewControllerWithIdentifier("ContainerRoot") as? SlideMenuUINavigationController
  }
  
}