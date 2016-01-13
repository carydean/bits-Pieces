//
//  CreateTeamViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 10/24/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit
import Contacts

let kIPhoneSixScreenWidth: CGFloat       = 375
let kIPhoneSixPlusScreenWidth: CGFloat   = 414

var sidebarCoverView1: UIView!

class CreateTeamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    

  //  @IBOutlet weak var searchAllButton: UIButton!
  //  @IBOutlet weak var searchFacebookButton: UIButton!
  //  @IBOutlet weak var searchContactsButton: UIButton!
    var searchAllButton: UIButton!
    var searchFacebookButton: UIButton!
    var searchContactsButton: UIButton!
    var searchTeamMembersTextfield: UITextField!
    
    @IBOutlet weak var teamNameTextField: UITextField!
    
    @IBOutlet weak var playersTableView: UITableView!
    @IBOutlet weak var teamMembersTableView: UITableView!
    @IBOutlet weak var contactsLabel: UILabel!
    @IBOutlet weak var contactsSelectionButton: UIButton!
    @IBOutlet weak var teamColorButton: UIButton!
    @IBOutlet weak var teamMemberView: UIView!
    @IBOutlet weak var swipeUpView: UIView!
        
    private var store: CNContactStore!
    
    var friends = [String!]()
    var teamMembers = [String!]()
    var selectedContacts = [UInt]()
    
    var selectedIndexPathRow = -1
    
    var shouldDeselectSelectedContact: Bool!
    
    var isNewTeam: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.   
     //   self.playersTableView.layer.borderColor = UIColor(red: 134.0/255.0, green: 188.0/255.0, blue: 166.0/255.0, alpha: 1.0).CGColor
       // self.playersTableView.layer.borderWidth = 0.5
        store = CNContactStore()
      //  checkContactsAccess()
        
        sidebarCoverView1 = UIView(frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        sidebarCoverView1.backgroundColor = UIColor.lightGrayColor()
        sidebarCoverView1.hidden = true
        sidebarCoverView1.alpha = 0.5
        self.view.addSubview(sidebarCoverView1)
        
        friends.append("Blue")
        friends.append("Red")
        friends.append("Orange")
        friends.append("Purple")
        friends.append("Green")
        friends.append("Yellow")
        friends.append("Cyan")
        friends.append("Pink")
        
        for var i = 0; i<friends.count; i++ {
            self.selectedContacts.append(UInt(0))
        }
    }
    
    private func checkContactsAccess() {
        switch CNContactStore.authorizationStatusForEntityType(.Contacts) {
            // Update our UI if the user has granted access to their Contacts
        case .Authorized:
            self.accessGrantedForContacts()
            
            // Prompt the user for access to Contacts if there is no definitive answer
        case .NotDetermined :
            self.requestContactsAccess()
            
            // Display a message if the user has denied or restricted access to Contacts
        case .Denied,
        .Restricted:
            let alert = UIAlertController(title: "Privacy Warning!",
                message: "Permission was not granted for Contacts.",
                preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func requestContactsAccess() {
        
        store.requestAccessForEntityType(.Contacts) {granted, error in
            if granted {
                dispatch_async(dispatch_get_main_queue()) {
                    self.accessGrantedForContacts()
                    return
                }
            }
        }
    }
    
    // This method is called when the user has granted access to their address book data.
    private func accessGrantedForContacts() {
        // Load data from the plist file
        let toFetch = [CNContactGivenNameKey, CNContactFamilyNameKey]
        let request = CNContactFetchRequest(keysToFetch: toFetch)
        do{
            try store.enumerateContactsWithFetchRequest(request) {
                contact, stop in
                print(contact.givenName)
                print(contact.familyName)
                print(contact.identifier)
                
                self.selectedContacts.append(UInt(0))
                self.friends.append("\(contact.givenName)" + " \(contact.familyName)")
            }
        } catch let err{
            print(err)
        }
        self.playersTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func favButtonPressed(sender: AnyObject) {
    }

    @IBAction func showTeamMembersView() {
        self.swipeUpView.hidden = true
        self.teamMemberView.hidden = false
    }
    
    func imageResize (imageObj:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        imageObj.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let screenSizeWidth     = UIScreen.mainScreen().bounds.size.width

        var favBtnXPos: CGFloat
        
        if (screenSizeWidth == kIPhoneSixPlusScreenWidth) {
            favBtnXPos = 320
        } else if (screenSizeWidth == kIPhoneSixScreenWidth)  {
            favBtnXPos = 290
        }
        else {
            // iphone 4 & 5
            favBtnXPos = 230
        }

        if tableView == self.playersTableView {
            let cell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            
            cell.textLabel!.text = friends[indexPath.row]
            
            cell.selectionStyle = UITableViewCellSelectionStyle.Blue
            
            var image: UIImage!
            var favImage: UIImage!
            
            var selectedIconName: String!
            
            if selectedIndexPathRow == indexPath.row {
                if selectedContacts[indexPath.row] == 1 {
                    selectedIconName = "Select_Friend_Checkmark"
                } else {
                    selectedIconName = "Select_Friend_Circle"
                }
            } else {
                if selectedContacts[indexPath.row] == 1 {
                    selectedIconName = "Select_Friend_Checkmark"
                } else {
                    selectedIconName = "Select_Friend_Circle"
                }
            }
            
            if let path = NSBundle.mainBundle().pathForResource("\(selectedIconName)", ofType: "png") {
                // grab the original image
                image = UIImage(contentsOfFile: path)!
            }
            
            if let favPath = NSBundle.mainBundle().pathForResource("favEmptyButton", ofType: "png") {
                // grab the original image
                favImage = UIImage(contentsOfFile: favPath)!
            }
            
            let favBtn = UIButton(type: UIButtonType.Custom)
            favBtn.frame = CGRectMake(favBtnXPos, 0, 44, 44)
            
            let img:UIImage! = imageResize(favImage, sizeChange: CGSizeMake(30, 30))
            favBtn.setBackgroundImage(img, forState: UIControlState.Normal)

            favBtn.addTarget(self, action: "favButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            cell.contentView.addSubview(favBtn)
            
            cell.imageView!.backgroundColor = UIColor.whiteColor()
            cell.imageView?.alpha = 1.0
            
            cell.imageView!.image = imageResize(image, sizeChange: CGSizeMake(30, 30))
            
            cell.layer.borderColor = UIColor(red: 29.0/255.0, green: 53.0/255.0, blue: 67.0/255.0, alpha: 1.0).CGColor
            
            cell.layer.borderWidth = 0.5
            
            return cell
        } else {
            let mbrCell:UITableViewCell=UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "mbrCell")
            
            mbrCell.textLabel!.text = teamMembers[indexPath.row]
            
            mbrCell.layer.borderColor = UIColor(red: 29.0/255.0, green: 53.0/255.0, blue: 67.0/255.0, alpha: 1.0).CGColor
            
            mbrCell.layer.borderWidth = 0.5

            return mbrCell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.playersTableView {
            self.selectedIndexPathRow = indexPath.row

            if (selectedContacts[indexPath.row] == 0) {
                print("You selected cell #\(indexPath.row)! with textlabel = \(friends[indexPath.row])")
                selectedContacts[indexPath.row] = UInt(1)
                
                teamMembers.append(friends[indexPath.row])
            } else {
                selectedContacts[indexPath.row] = UInt(0)
            }
            
            self.playersTableView.reloadData()

        }
    }
    
    @IBAction func swipeBackFromTeamViewControllerUnwindAction(unwindSegue: UIStoryboardSegue) {
        
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let screenSizeWidth     = UIScreen.mainScreen().bounds.size.width
        
        var searchTeammatesXPos:    CGFloat
        var newTeamBtnXPos:         CGFloat
        var headerWidth:            CGFloat
        
        if (screenSizeWidth == kIPhoneSixPlusScreenWidth) {
            newTeamBtnXPos          = 380
            headerWidth             = 380
            searchTeammatesXPos     = 75
        } else if (screenSizeWidth == kIPhoneSixScreenWidth)  {
            newTeamBtnXPos          = 355
            headerWidth             = 355
            searchTeammatesXPos     = 60
        }
        else {
            // iphone 4 & 5
            newTeamBtnXPos          = 300
            headerWidth             = 300
            searchTeammatesXPos     = 33
        }

        if (isNewTeam == nil) {
            let header = UIView(frame: CGRectMake(0,0,headerWidth,66))
          //  header.backgroundColor = UIColor(red: 243.0/255.0, green: 218.0/255.0, blue: 205.0/255.0, alpha: 1.0)
            
            header.backgroundColor = UIColor.clearColor()
            
            self.playersTableView.backgroundColor = UIColor.clearColor()
            
            let newTeamImageView = UIImageView(image: UIImage(named: "createTeamButton.png"))
            
            let newTeamBtn = UIButton(type: UIButtonType.RoundedRect)
            newTeamBtn.frame = CGRectMake(header.center.x - 60, -7, 110, 110)
            newTeamBtn.setTitle("Create Team", forState: UIControlState.Normal)
            newTeamBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            newTeamBtn.addTarget(self, action: "newTeamBtnPressed", forControlEvents: UIControlEvents.TouchUpInside)
            newTeamBtn.titleLabel?.font = UIFont(name: "GeoSansLight", size: 18)
            newTeamImageView.frame = CGRectMake(header.center.x - 50, 0, 100, 100)

            header.addSubview(newTeamImageView)
            header.addSubview(newTeamBtn)

            return header
        } else {
            let header = UIView(frame: CGRectMake(0,0,headerWidth,66))
          //  header.backgroundColor = UIColor(red: 243.0/255.0, green: 218.0/255.0, blue: 205.0/255.0, alpha: 1.0)
            
            header.backgroundColor = UIColor.clearColor()
            
            self.playersTableView.backgroundColor = UIColor.clearColor()

            searchAllButton = UIButton(type: UIButtonType.Custom)
            searchAllButton.frame = CGRectMake(searchTeammatesXPos, 3, 60, 60)
            searchAllButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            searchAllButton.setBackgroundImage(UIImage(named: "Search_Filter_All_Button.png"), forState: UIControlState.Normal)
            searchAllButton.tag = 0
            searchAllButton.setTitle("All", forState: UIControlState.Normal)
            searchAllButton.addTarget(self, action: "searchButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)

            header.addSubview(searchAllButton)

            searchFacebookButton = UIButton(type: UIButtonType.Custom)
            searchFacebookButton.frame = CGRectMake(searchAllButton.frame.origin.x + searchAllButton.frame.width + 20, 3, 60, 60)
            searchFacebookButton.tag = 1
            searchFacebookButton.setBackgroundImage(UIImage(named: "Search_Filter_FB_Button.png"), forState: UIControlState.Normal)
            searchFacebookButton.addTarget(self, action: "searchButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            
            header.addSubview(searchFacebookButton)

            searchContactsButton = UIButton(type: UIButtonType.Custom)
            searchContactsButton.frame = CGRectMake(searchFacebookButton.frame.origin.x + searchFacebookButton.frame.width + 20, 3, 60, 60)
            searchContactsButton.tag = 2
            searchContactsButton.setBackgroundImage(UIImage(named: "Search_Filter_Contacts_Button.png"), forState: UIControlState.Normal)
            searchContactsButton.addTarget(self, action: "newTeamBtnPressed", forControlEvents: UIControlEvents.TouchUpInside)

            header.addSubview(searchContactsButton)
            
            searchTeamMembersTextfield = UITextField(frame: CGRectMake(searchTeammatesXPos,searchContactsButton.frame.origin.y + searchContactsButton.frame.height + 10,224,30))
            searchTeamMembersTextfield.placeholder = "Search for Teammates"
            searchTeamMembersTextfield.borderStyle = UITextBorderStyle.RoundedRect
            header.addSubview(searchTeamMembersTextfield)
            searchTeamMembersTextfield.delegate = self

            return header
        }
    }
    
    func newTeamBtnPressed() {
        isNewTeam = true
        teamNameTextField.hidden = false
        self.swipeUpView.hidden = false
        print("New Team Button Pressed")
        friends = [String!]()
        checkContactsAccess()
        self.playersTableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.playersTableView {
            return friends.count
        }
        return teamMembers.count
    }
    
    func showHideRightSideWithSidebar() {
        if sidebarCoverView1.hidden == true {
            sidebarCoverView1.hidden = false
        } else {
            sidebarCoverView1.hidden = true
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if isNewTeam != nil {
            return 106
        }
        return 106
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender!.isKindOfClass(UIButton) {
            let vc = segue.destinationViewController as? SidebarContainerViewController
            vc!.viewControllerId = "CreateTeamFindRivalsSidebarNavigationController"
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
