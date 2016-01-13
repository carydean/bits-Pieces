//
//  FeedViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 11/11/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit

var fdSidebarCoverView: UIView!

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var itemImageView: UIImageView!
    var itemImages: [UIImage]! = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fdSidebarCoverView = UIView(frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        fdSidebarCoverView.backgroundColor = UIColor.lightGrayColor()
        fdSidebarCoverView.hidden = true
        fdSidebarCoverView.alpha = 0.5
        self.view.addSubview(fdSidebarCoverView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createHuntButtonPressed(sender: AnyObject) {
    }
    
    func showHideRightSideWithSidebar() {
        if fdSidebarCoverView.hidden == true {
            fdSidebarCoverView.hidden = false
        } else {
            fdSidebarCoverView.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       // let vc = segue.destinationViewController as? SidebarContainerViewController
       // vc!.viewControllerId = "FindRivalBAPSidebarNavigationController"
        
        let tabBtn:UIButton! = sender as? UIButton
        
        let vc = segue.destinationViewController as? SidebarContainerViewController
        
        switch tabBtn!.tag {
        case 0:// list button
            vc!.viewControllerId = "FindRivalBAPSidebarNavigationController"
        case 1:
            vc!.viewControllerId = "FeedSidebarNavigationController"
        case 2:
            vc!.viewControllerId = "HistorySidebarNavigationController"
        default:
            print("")
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath)
        
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    @IBAction func swipeBackFromTeamViewControllerUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
