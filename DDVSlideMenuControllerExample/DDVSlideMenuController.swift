//
//  DDVSlideMenuController.swift
//  DDVSlideMenuControllerExample
//
//  Created by Đặng Vinh on 5/4/15.
//  Copyright (c) 2015 DVISoft. All rights reserved.
//

import UIKit

@objc protocol DDVSlideMenuControllerDelegate {
    optional func DDVSlideMenuControllerWillShowLeftPanel()
    optional func DDVSlideMenuControllerWillShowRightPanel()
    
    optional func DDVSlideMenuControllerDidShowLeftPanel()
    optional func DDVSlideMenuControllerDidShowRightPanel()

    optional func DDVSlideMenuControllerWillHideLeftPanel()
    optional func DDVSlideMenuControllerWillHideRightPanel()
    
    optional func DDVSlideMenuControllerDidHideLeftPanel()
    optional func DDVSlideMenuControllerDidHideRightPanel()
}

class DDVSlideMenuController: UIViewController {
    
    enum SlidePanelState {
        case Left
        case Right
        case Top
        case Bottom
        case None
    }
    
    var centerViewController: UIViewController!
    var leftViewController: UIViewController?
    var rightViewController: UIViewController?
    var topViewController: UIViewController?
    var bottomViewController: UIViewController?
    
    let deviceWidth = UIScreen.mainScreen().bounds.width
    let deviceHeight = UIScreen.mainScreen().bounds.height
    
    var slidePanelState: SlidePanelState = .None
    var delegate: DDVSlideMenuControllerDelegate?
    
    weak var panGesture: UIPanGestureRecognizer?
    weak var panGestureForTop: UIPanGestureRecognizer?
    
    var distanceOffSet: CGFloat = 70
    var timeSliding: NSTimeInterval = 0.5
    var shadowOpacity: Float = 0.8
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init methods
    
    init(centerViewController: UIViewController, leftViewController: UIViewController, rightViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        addCenterViewController(centerViewController)
        addLeftViewController(leftViewController)
        addRightViewController(rightViewController)
    }
    
    init(centerViewController: UIViewController, leftViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        addCenterViewController(centerViewController)
        addLeftViewController(leftViewController)
    }
    
    init(centerViewController: UIViewController, rightViewController: UIViewController) {
        super.init(nibName: nil, bundle: nil)
        addCenterViewController(centerViewController)
        addRightViewController(rightViewController)
    }
    
    // MARK: - View state methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Add all panel in view
    
    func addCenterViewController(centerVC: UIViewController) {
        centerViewController = centerVC
        centerViewController.view.frame = view.frame
        centerViewController.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.addChildViewController(centerViewController)
        view.addSubview(centerViewController.view)
        centerViewController.didMoveToParentViewController(self)
        addPanGestureRecognizer()
    }
    
    func addLeftViewController(leftVC: UIViewController) {
        leftViewController = leftVC
        leftViewController?.view.frame = CGRectMake(0, 0, deviceWidth - distanceOffSet, deviceHeight)
        leftViewController?.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        addChildPanelViewController(leftViewController!)
    }
    
    func addRightViewController(rightVC: UIViewController) {
        rightViewController = rightVC
        rightViewController?.view.frame = CGRectMake(distanceOffSet, 0, deviceWidth - distanceOffSet, deviceHeight)
        rightViewController?.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        addChildPanelViewController(rightViewController!)
    }
    
    func addTopViewController(topVC: UIViewController) {
        topViewController = topVC
        topViewController?.view.frame = CGRectMake(0, -CGFloat(topViewController!.view.bounds.height)/2, CGFloat(topViewController!.view.bounds.width), CGFloat(topViewController!.view.bounds.height))
        topViewController?.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        addChildPanelViewController(topViewController!)
    }
    
    func addBottomViewController(topVC: UIViewController) {
        bottomViewController = topVC
        bottomViewController?.view.frame = CGRectMake(0, deviceHeight + CGFloat(bottomViewController!.view.bounds.height)/2, CGFloat(bottomViewController!.view.bounds.width), CGFloat(bottomViewController!.view.bounds.height))
        bottomViewController?.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        addChildPanelViewController(bottomViewController!)
    }
    
    private func addChildPanelViewController(childVC: UIViewController) {
        addChildViewController(childVC)
        view.insertSubview(childVC.view, atIndex: 0)
        childVC.didMoveToParentViewController(self)
    }
    
    // MARK: - UIGestureRecognizer Methods
    
    private func addPanGestureRecognizer() {
        var panG = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
        centerViewController.view.addGestureRecognizer(panG)
        panGesture = panG
    }
    
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        var getVeclocity = gesture.velocityInView(view).x > 0
        switch(gesture.state) {
        case .Began:
            if(getVeclocity) {
                if(slidePanelState == .None && leftViewController != nil) {
                    delegate?.DDVSlideMenuControllerWillShowLeftPanel?()
                    slidePanelState = .Left
                    addShadowOpacityToView(centerViewController.view)
                    view.sendSubviewToBack(self.rightViewController!.view)
                }
            } else {
                if(slidePanelState == .None && rightViewController != nil) {
                    delegate?.DDVSlideMenuControllerWillShowRightPanel?()
                    slidePanelState = .Right
                    addShadowOpacityToView(centerViewController.view)
                    view.sendSubviewToBack(self.leftViewController!.view)
                }
            }
        case .Changed:
            if(slidePanelState == .Left && CGRectGetMinX(centerViewController.view.frame) <= (deviceWidth - distanceOffSet)) {
                centerViewController.view.center.x = centerViewController.view.center.x + gesture.translationInView(view).x
            } else if(slidePanelState == .Right && CGRectGetMaxX(centerViewController.view.frame) >= distanceOffSet) {
                centerViewController.view.center.x = centerViewController.view.center.x + gesture.translationInView(view).x
            }
            gesture.setTranslation(CGPointZero, inView: view)
        
        case .Ended:
            if(slidePanelState == .Left) {
                var isGreaterThanScreen = centerViewController.view.center.x > deviceWidth
                animatePanelAccordingToPositionOfCenterView(isGreaterThanScreen)
            } else if(slidePanelState == .Right) {
                var isLessThanScreen = centerViewController.view.center.x < 0
                animatePanelAccordingToPositionOfCenterView(isLessThanScreen)
            }
        default:
            break
        }
    }
    
    // MARK: - Animation Panel Methods
    
    private func animatePanelAccordingToPositionOfCenterView(canSlide: Bool) {
        if(canSlide) {
            if(slidePanelState == .Left) {
                makeAnimationForViewToNewPositionX(animationView: centerViewController.view, positionX: deviceWidth + (deviceWidth/2 - distanceOffSet)) { finished in
                    delegate?.DDVSlideMenuControllerDidShowLeftPanel?()
                }
            } else if(slidePanelState == .Right) {
                makeAnimationForViewToNewPositionX(animationView: centerViewController.view, positionX: distanceOffSet - (deviceWidth/2)) { finished in
                    delegate?.DDVSlideMenuControllerDidShowRightPanel?()
                }
            }
        } else {
            hidePanelAction()
        }
    }
    
    private func makeAnimationForViewToNewPositionX(#animationView: UIView, positionX posX: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(timeSliding, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            animationView.center.x = posX
            }, completion: completion
        )
    }
    
    private func makeAnimationForViewToNewPositionY(#animationView: UIView, positionY posY: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(timeSliding, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            animationView.center.y = posY
            }, completion: completion
        )
    }
    
    private func hidePanelAction() {
        if self.slidePanelState == .Left {
            delegate?.DDVSlideMenuControllerWillHideLeftPanel?()
        } else if self.slidePanelState == .Right {
            delegate?.DDVSlideMenuControllerWillHideRightPanel?()
        }
        makeAnimationForViewToNewPositionX(animationView: centerViewController.view, positionX: deviceWidth/2) { finished in
            if self.slidePanelState == .Left {
                self.delegate?.DDVSlideMenuControllerDidHideLeftPanel?()
            } else if self.slidePanelState == .Right {
                self.delegate?.DDVSlideMenuControllerDidHideRightPanel?()
            }
            self.slidePanelState = .None
        }
        
    }
    
    // MARK: - Toggle Methods
    
    private func toggleLeftPanelAction() {
        if leftViewController == nil { return }
        if slidePanelState == .None {
            delegate?.DDVSlideMenuControllerWillShowLeftPanel?()
            slidePanelState = .Left
            view.sendSubviewToBack(self.rightViewController!.view)
            makeAnimationForViewToNewPositionX(animationView: centerViewController.view, positionX: deviceWidth + (deviceWidth/2 - distanceOffSet)) { finished in
                delegate?.DDVSlideMenuControllerDidShowLeftPanel?()
            }
        } else {
            hidePanelAction()
        }
    }
    
    private func toggleRightPanelAction() {
        if rightViewController == nil { return }
        if slidePanelState == .None {
            delegate?.DDVSlideMenuControllerWillShowRightPanel?()
            slidePanelState = .Right
            view.sendSubviewToBack(self.leftViewController!.view)
            makeAnimationForViewToNewPositionX(animationView: centerViewController.view, positionX: distanceOffSet - (deviceWidth/2)) { finished in
                delegate?.DDVSlideMenuControllerDidShowRightPanel?()
            }
        } else {
            hidePanelAction()
        }
    }
    
    private func toggleTopPanelAction() {
        if topViewController == nil { return }
        if slidePanelState == .None {
            slidePanelState = .Top
            sendAllSubViewsToBackExcept(topViewController!.view)
            makeAnimationForViewToNewPositionY(animationView: topViewController!.view, positionY: CGFloat(topViewController!.view.bounds.height)/2, completion: nil)
            makeAnimationForViewToNewPositionY(animationView: centerViewController!.view, positionY: CGFloat(topViewController!.view.bounds.height) + CGFloat(centerViewController.view.bounds.height
                )/2, completion: nil)
        } else {
            makeAnimationForViewToNewPositionY(animationView: topViewController!.view, positionY: -CGFloat(topViewController!.view.bounds.height)/2, completion: nil)
            makeAnimationForViewToNewPositionY(animationView: centerViewController!.view, positionY: deviceHeight/2, completion: nil)
            slidePanelState = .None
        }
    }
    
    private func toggleBottomPanelAction() {
        if bottomViewController == nil { return }
        if slidePanelState == .None {
            slidePanelState = .Bottom
            sendAllSubViewsToBackExcept(bottomViewController!.view)
            makeAnimationForViewToNewPositionY(animationView: bottomViewController!.view, positionY: deviceHeight - CGFloat(bottomViewController!.view.bounds.height)/2, completion: nil)
            makeAnimationForViewToNewPositionY(animationView: centerViewController!.view, positionY: deviceHeight - CGFloat(bottomViewController!.view.bounds.height) - CGFloat(centerViewController.view.bounds.height
                )/2, completion: nil)
        } else {
            makeAnimationForViewToNewPositionY(animationView: bottomViewController!.view, positionY: deviceHeight + CGFloat(bottomViewController!.view.bounds.height)/2, completion: nil)
            makeAnimationForViewToNewPositionY(animationView: centerViewController!.view, positionY: deviceHeight/2, completion: nil)
            slidePanelState = .None
        }

    }
    
    // MARK: Supporting Methods
    
    private func addShadowOpacityToView(myView: UIView) {
        myView.layer.shadowOpacity = shadowOpacity
    }
    
    private func sendAllSubViewsToBackExcept(holdView: UIView) {
        for subView in view.subviews {
            if (subView as? UIView) != holdView && (subView as? UIView) != centerViewController.view {
                view.sendSubviewToBack((subView as? UIView)!)
            }
        }
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    
    func ddvSlideMenuController() -> DDVSlideMenuController? {
        var viewController: UIViewController? = self
        while viewController != nil {
            if viewController is DDVSlideMenuController {
                return viewController as? DDVSlideMenuController
            }
            viewController = viewController?.parentViewController
        }
        return nil
    }
    
    func addLeftToggleButton(#title: String) {
        var button = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("toggleLeftPanel"))
        navigationItem.setLeftBarButtonItem(button, animated: true)
    }
    
    func addRightToggleButton(#title: String) {
        var button = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: Selector("toggleRightPanel"))
        navigationItem.setRightBarButtonItem(button, animated: true)
    }
    
    func toggleLeftPanel() {
        ddvSlideMenuController()?.toggleLeftPanelAction()
    }
    
    func toggleRightPanel() {
        ddvSlideMenuController()?.toggleRightPanelAction()
    }
    
    func toggleTopPanel() {
        ddvSlideMenuController()?.toggleTopPanelAction()
    }
    
    func toggleBottomPanel() {
        ddvSlideMenuController()?.toggleBottomPanelAction()
    }
    
    func hidePanel() {
        ddvSlideMenuController()?.hidePanelAction()
    }
    
}
