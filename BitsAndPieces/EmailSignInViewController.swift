    //
//  EmailSignInViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 10/23/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit

class EmailSignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signInButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func shouldEnableSignInButton() {
        
    }
    
    func validateEmail(candidate: String) -> Bool {
       // let emailRegex: String = "\\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}\\b"

        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluateWithObject(candidate)
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if self.validateEmail(textField.text!) {
            signInButton.enabled = true
        } else {
            signInButton.enabled = false
        }
        
        return true
    }
    
    /**
     * Called when 'return' key pressed. return NO to ignore.
     */
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as? SidebarContainerViewController
        vc!.viewControllerId = "EmailCreateHuntSidebarNavigationController"
    }
}
