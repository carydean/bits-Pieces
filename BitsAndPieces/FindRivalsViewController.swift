//
//  FindRivalsViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 11/10/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit

var frSidebarCoverView: UIView!
let dictionary = [
                    "A": ["Affenpoo", "Affenpug", "Affenshire", "Affenwich", "Afghan Collie", "Afghan Hound"],
                    "B": ["Bagle Hound", "Boxer","Bear", "Black Swan", "Buffalo"],
                    "C": ["Camel", "Cockatoo"],
                    "D": ["Dog", "Donkey"],
                    "E": ["Emu"],
                    "F": ["Frog"],
                    "G": ["Giraffe", "Greater Rhea"],
                    "H": ["Hippopotamus", "Horse"],
                    "I": ["iAnimal"],
                    "J": ["Jackel"],
                    "K": ["Koala"],
                    "L": ["Lion", "Llama"],
                    "M": ["Manatus", "Meerkat"],
                    "N": ["New Animal"],
                    "O": ["Orange"],
                    "P": ["Panda", "Peacock", "Pig", "Platypus", "Polar Bear"],
                    "Q": ["Queen"],
                    "R": ["Rhinoceros"],
                    "S": ["Seagull"],
                    "T": ["Tasmania Devil"],
                    "W": ["Whale", "Whale Shark", "Wombat"]
                ]

struct Objects {
    var sectionName : String!
    var sectionObjects : [String]!
}

var objectArray = [Objects]()

class FindRivalsViewController:UIViewController, UITableViewDataSource, UITableViewDelegate {
    let indexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        frSidebarCoverView = UIView(frame:CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        frSidebarCoverView.backgroundColor = UIColor.lightGrayColor()
        frSidebarCoverView.hidden = true
        frSidebarCoverView.alpha = 0.5
        self.view.addSubview(frSidebarCoverView)
        
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")

        // SORTING [SINCE A DICTIONARY IS AN UNSORTED LIST]
      //  for (key, value) in dictionary {
       for (key, value) in Array(dictionary).sort({ $0.0 < $1.0 }) {
            print("\(key) -> \(value)")
            objectArray.append(Objects(sectionName: key, sectionObjects: value))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createHuntButtonPressed(sender: AnyObject) {
    }
    
    func showHideRightSideWithSidebar() {
        if frSidebarCoverView.hidden == true {
            frSidebarCoverView.hidden = false
        } else {
            frSidebarCoverView.hidden = true
        }
    }
    
    // MARK: UITableViewDelegate

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return objectArray.count
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return indexTitles
    }
    
    func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        return indexTitles.indexOf(title)!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectArray[section].sectionObjects.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        // SETTING UP YOUR CELL
        cell.textLabel?.text = objectArray[indexPath.section].sectionObjects[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectArray[section].sectionName
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
}
