//
//  CenterVC.swift
//  DDVSlideMenuControllerExample
//
//  Created by Đặng Vinh on 5/4/15.
//  Copyright (c) 2015 DVISoft. All rights reserved.
//

import UIKit

class CenterVC: UIViewController, DDVSlideMenuControllerDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Button Actions
    
    @IBAction func toggleTopPanelAction(sender: AnyObject) {
        ddvSlideMenuController()?.toggleTopPanel()
    }
    
    @IBAction func toggleBottomPanelAction(sender: AnyObject) {
        ddvSlideMenuController()?.toggleBottomPanel()
    }
    
    // MARK: - DDVSlideMenuController Delegate
    
    // Left and right
//    func DDVSlideMenuControllerWillShowLeftPanel() {
//        println("Will show left panel")
//    }
//    
//    func DDVSlideMenuControllerWillShowRightPanel() {
//        println("Will show right panel")
//    }
//    
//    func DDVSlideMenuControllerDidShowLeftPanel() {
//        println("Did show left panel")
//    }
//    
//    func DDVSlideMenuControllerDidShowRightPanel() {
//        println("Did show right panel")
//    }
//    
//    func DDVSlideMenuControllerWillHideLeftPanel() {
//        println("Will hide left panel")
//    }
//    
//    func DDVSlideMenuControllerWillHideRightPanel() {
//        println("Will hide right panel")
//    }
//    
//    func DDVSlideMenuControllerDidHideLeftPanel() {
//        println("Did hide left panel")
//    }
//    
//    func DDVSlideMenuControllerDidHideRightPanel() {
//        println("Did hide right panel")
//    }
//    
//    
//    //Top and bottom
//    func DDVSlideMenuControllerWillShowTopPanel() {
//        println("Will show top panel")
//    }
//    
//    func DDVSlideMenuControllerWillShowBottomPanel() {
//        println("Will show bottom panel")
//    }
//    
//    func DDVSlideMenuControllerDidShowTopPanel() {
//        println("Did show top panel")
//    }
//    
//    func DDVSlideMenuControllerDidShowBottomPanel() {
//        println("Did show bottom panel")
//    }
//    
//    func DDVSlideMenuControllerWillHideTopPanel() {
//        println("Will hide top panel")
//    }
//    
//    func DDVSlideMenuControllerWillHideBottomPanel() {
//        println("Will hide bottom panel")
//    }
//    
//    func DDVSlideMenuControllerDidHideTopPanel() {
//        println("Did hide top panel")
//    }
//    
//    func DDVSlideMenuControllerDidHideBottomPanel() {
//        println("Did hide bottom panel")
//    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
