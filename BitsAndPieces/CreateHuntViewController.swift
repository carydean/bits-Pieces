//
//  CreateHuntViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 10/24/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit

var sidebarCoverView: UIView!

class CreateHuntViewController: UIViewController {
    @IBOutlet weak var createHuntButton: UIButton!
    @IBOutlet weak var upgradeButton: UIButton!
    @IBOutlet weak var basicGameButton: UIButton!
    @IBOutlet weak var challengeGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sidebarCoverView = UIView(frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        sidebarCoverView.backgroundColor = UIColor.lightGrayColor()
        sidebarCoverView.hidden = true
        sidebarCoverView.alpha = 0.5
        self.view.addSubview(sidebarCoverView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createHuntButtonPressed(sender: AnyObject) {
        UIView.animateWithDuration(1.0, delay: 0.0,
            options: [.CurveEaseOut], animations: {
                self.basicGameButton.alpha = 1.0
                self.basicGameButton.hidden = false
            }, completion: nil)
        UIView.animateWithDuration(1.0, delay: 0.25,
            options: [.CurveEaseOut], animations: {
                self.challengeGameButton.alpha = 1.0
                self.challengeGameButton.hidden = false
            }, completion: nil)

    }
    
    func showHideRightSideWithSidebar() {
        if sidebarCoverView.hidden == true {
            sidebarCoverView.hidden = false
        } else {
            sidebarCoverView.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as? SidebarContainerViewController
        vc!.viewControllerId = "CreateHuntCreateTeamSidebarNavigationController"
    }
}
