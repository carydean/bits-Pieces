//
//  BitsAndPiecesListViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 11/11/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit

var sidebarCoverView2: UIView!

class BitsAndPiecesListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var finishButton: UIButton!
    
    var itemImageView: UIImageView!
    var cameraButton: UIButton!
    
    var cameraButtonTag:Int!
    
    var items: [String]!
    var itemImages: [UIImage]! = [UIImage]()
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sidebarCoverView2 = UIView(frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        sidebarCoverView2.backgroundColor = UIColor.lightGrayColor()
        sidebarCoverView2.hidden = true
        sidebarCoverView2.alpha = 0.5
        self.view.addSubview(sidebarCoverView2)
        
        self.tableView.layer.borderColor = UIColor(red: 25.0/255.0, green: 70.0/255.0, blue: 86.0/255.0, alpha: 1.0).CGColor
        self.tableView.layer.borderWidth = 1.0
        
        items = ["right hand glove", "red pencil", "toilet plunger", "golf ball", "red suspenders", "nose hair trimmer", "bottle of exlax", "a 45 record" ,"a 9 volt battery", "picture of mailman delivering mail", "a plastic easter egg"]
        
        let img:UIImage! = UIImage(named: "photoItemFound.png")
                
        for var idx = 0; idx < items.count; idx++ {
            itemImages.append(img)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createHuntButtonPressed(sender: AnyObject) {
    }
    
    func showHideRightSideWithSidebar() {
        if sidebarCoverView2.hidden == true {
            sidebarCoverView2.hidden = false
        } else {
            sidebarCoverView2.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
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

    @IBAction func tabBarPessed(sender: AnyObject) {
        let button = sender as! UIButton
        
        if button.tag == 1 { // Feed
        print("Button \(button.tag) was pressed!")
        } else if button.tag == 2 { // History
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) 
        
        cell.textLabel!.text = items[indexPath.row]
        cell.textLabel!.backgroundColor = UIColor.clearColor()
        cell.textLabel!.textAlignment = NSTextAlignment.Center
        
        itemImageView = UIImageView(frame: CGRectMake(5, 5, 44, 44))
        
        itemImageView.image = itemImages[indexPath.row]
        
        cell.contentView.addSubview(itemImageView)
        
        cameraButton = UIButton(type: UIButtonType.Custom)
        cameraButton.frame = CGRectMake(271, 5, 57, 44)
        cameraButton.setBackgroundImage(UIImage(named: "Camera Icon.png"), forState: UIControlState.Normal)
        cameraButton.addTarget(self, action: "cameraButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        cameraButton.tag = indexPath.row
        cell.contentView.addSubview(cameraButton)
                    
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    @IBAction func swipeBackFromTeamViewControllerUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0,0,tableView.frame.width,54))
        finishButton = UIButton(frame: view.frame)
        finishButton.backgroundColor = UIColor(red: 134.0/255.0, green: 188.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        finishButton.addTarget(self, action: "finishButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        finishButton.titleLabel?.textColor = UIColor.whiteColor()
        finishButton.setTitle("Finish!", forState: UIControlState.Normal)
        view.addSubview(finishButton)
        
        return view
    }
    
    func cameraButtonPressed(sender: AnyObject) {
        let button = sender as! UIButton
        
        cameraButtonTag = button.tag
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .Camera
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func finishedButtonPressed() {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imagePicker.dismissViewControllerAnimated(true, completion: nil)
        itemImages[cameraButtonTag] = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        tableView.reloadData()
    }
}
