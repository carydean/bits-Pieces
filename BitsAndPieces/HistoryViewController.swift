//
//  HistoryViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 12/8/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit

var histSidebarCoverView: UIView!

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var cellOutlineView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        histSidebarCoverView = UIView(frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        histSidebarCoverView.backgroundColor = UIColor.lightGrayColor()
        histSidebarCoverView.hidden = true
        histSidebarCoverView.alpha = 0.5
        self.view.addSubview(histSidebarCoverView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func showHideRightSideWithSidebar() {
        if sidebarCoverView2.hidden == true {
            sidebarCoverView2.hidden = false
        } else {
            sidebarCoverView2.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //let vc = segue.destinationViewController as? SidebarContainerViewController
        //vc!.viewControllerId = "HistorySidebarNavigationController"
        
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
        
        let cellOutlineView = UIView(frame: CGRectMake(14,20,359,53))
        cellOutlineView.layer.borderColor = UIColor(red: 25.0/255.0, green: 70.0/255.0, blue: 86.0/255.0, alpha: 1.0).CGColor
        cellOutlineView.layer.borderWidth = 1.0
        cellOutlineView.backgroundColor = UIColor.clearColor()
        
        let circleImageView = UIImageView(frame: CGRectMake(2, 0, 40, 40))
        circleImageView.image = UIImage(imageLiteral: "Side_Panel_Tutorial_Button.png")
        cell.addSubview(circleImageView)
        
        cell.contentView.addSubview(cellOutlineView)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    @IBAction func swipeBackFromTeamViewControllerUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    
    /* func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
    }*/
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
