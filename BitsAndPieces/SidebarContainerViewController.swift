//
//  SidebarContainerViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 12/2/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit

class SidebarContainerViewController: UIViewController {
    var viewControllerId:String!
    
    var leftViewController: UIViewController? {
        willSet{
            if self.leftViewController != nil {
                if self.leftViewController!.view != nil {
                    self.leftViewController!.view!.removeFromSuperview()
                }
                self.leftViewController!.removeFromParentViewController()
            }
        }
        
        didSet{
            
            self.view!.addSubview(self.leftViewController!.view)
            self.addChildViewController(self.leftViewController!)
        }
    }
    
    var rightViewController: UIViewController? {
        willSet {
            if self.rightViewController != nil {
                if self.rightViewController!.view != nil {
                    self.rightViewController!.view!.removeFromSuperview()
                }
                self.rightViewController!.removeFromParentViewController()
            }
        }
        
        didSet{
            
            self.view!.addSubview(self.rightViewController!.view)
            self.addChildViewController(self.rightViewController!)
        }
    }
    
    var menuShown: Bool = false
    
    @IBAction func swipeRight(sender: UISwipeGestureRecognizer) {
        showMenu()
        
    }
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        hideMenu()
    }
    
    func showMenu() {
        UIView.animateWithDuration(0.3, animations: {
            self.rightViewController!.view.frame = CGRect(x: self.view.frame.origin.x + 235, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { (Bool) -> Void in
                self.menuShown = true
                
                switch self.viewControllerId! {
                    case "CreateHuntCreateTeamSidebarNavigationController":
                        CreateTeamViewController().showHideRightSideWithSidebar()
                    case "EmailCreateHuntSidebarNavigationController":
                        CreateHuntViewController().showHideRightSideWithSidebar()
                    case "CreateTeamFindRivalsSidebarNavigationController":
                        FindRivalsViewController().showHideRightSideWithSidebar()
                    case "FindRivalBAPSidebarNavigationController":
                        BitsAndPiecesListViewController().showHideRightSideWithSidebar()
                    case "FeedSidebarNavigationController":
                        FeedViewController().showHideRightSideWithSidebar()
                    case "HistorySidebarNavigationController":
                        HistoryViewController().showHideRightSideWithSidebar()

                default:
                    print("")
                }
        })
    }
    
    func hideMenu() {
        UIView.animateWithDuration(0.3, animations: {
            self.rightViewController!.view.frame = CGRect(x: 0, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: { (Bool) -> Void in
                self.menuShown = false

                switch self.viewControllerId! {
                case "CreateHuntCreateTeamSidebarNavigationController":
                    CreateTeamViewController().showHideRightSideWithSidebar()
                case "EmailCreateHuntSidebarNavigationController":
                    CreateHuntViewController().showHideRightSideWithSidebar()
                case "CreateTeamFindRivalsSidebarNavigationController":
                    FindRivalsViewController().showHideRightSideWithSidebar()
                case "FindRivalBAPSidebarNavigationController":
                    BitsAndPiecesListViewController().showHideRightSideWithSidebar()
                case "FeedSidebarNavigationController":
                    FeedViewController().showHideRightSideWithSidebar()
                case "HistorySidebarNavigationController":
                    HistoryViewController().showHideRightSideWithSidebar()

                default:
                    print("")
                }
})
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc: UINavigationController = storyboard.instantiateViewControllerWithIdentifier(viewControllerId!) as! UINavigationController
        
        let huntsViewController: HuntsViewController = storyboard.instantiateViewControllerWithIdentifier("HuntsViewController")as! HuntsViewController
        
        self.leftViewController = huntsViewController
        self.rightViewController = vc
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
