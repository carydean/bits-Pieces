//
//  ViewController.swift
//  BitsAndPieces
//
//  Created by CTO on 10/16/15.
//  Copyright © 2015 Pocket Me Apps. All rights reserved.
//

import UIKit

// A delay function
func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var bitsNPiecesTitleLabel: UILabel!
    @IBOutlet weak var signInLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func fbButtonPressed(sender: AnyObject) {
        let login : FBSDKLoginManager = FBSDKLoginManager()
        //FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
        
        login.logInWithReadPermissions(["public_profile", "email", "user_friends"], fromViewController: self, handler: { (response:FBSDKLoginManagerLoginResult!, error: NSError!) in
            if(error != nil){
                // Handle error
            }
            else if(response.isCancelled){
                // Authorization has been canceled by user
            }
            else {
                // Authorization successful
                // println(FBSDKAccessToken.currentAccessToken())
                // no longer necessary as the token is already in the response
                print(response.token.tokenString)
            }
        })
    }
    
    func fetchUserInfo() {
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
    
            print("Token is available")
        
            FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler( { (connection, result, error) -> Void in
                if(error != nil) {
                    // Handle error
                    print("Fetched User Information \(result)")
                } else {
                    print("Error \(error)")
                }
            })
        }
    }

    
    @IBAction func emailButtonPressed(sender: AnyObject) {
    }
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
            }
        })
    }
}

