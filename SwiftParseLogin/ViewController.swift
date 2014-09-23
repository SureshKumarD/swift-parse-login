//
//  ViewController.swift
//  SwiftParseLogin
//
//  Created by Suresh on 19/09/14.
//  Copyright (c) 2014 Neev. All rights reserved.
//

import UIKit

class ViewController: UIViewController,PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.navigationController.navigationBar.hidden = true
        if(PFUser.currentUser() == nil){
            var logInViewController = PFLogInViewController()
            logInViewController.delegate = self
            
            //customize logInViewController
            logInViewController.fields = PFLogInFields.UsernameAndPassword | PFLogInFields.LogInButton | PFLogInFields.PasswordForgotten | PFLogInFields.Facebook | PFLogInFields.SignUpButton
            logInViewController.facebookPermissions = NSArray(objects:"friends_about_me")
            logInViewController.logInView.logo  = UIImageView(image: UIImage(named: "Logo"))
            
            //create a signUpViewController instance
            var signUpViewController = PFSignUpViewController()
            signUpViewController.delegate = self
            
            //add signUpViewController instance to logInViewController for signUp module.
            logInViewController.signUpController = signUpViewController
            self.presentViewController(logInViewController, animated: true, completion: nil)
            
        }

        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func logInViewController(logInController: PFLogInViewController!, shouldBeginLogInWithUsername username: String!, password: String!) -> Bool {
        var uname = username as NSString
        var pswrd = password as NSString
        if ( ( uname.length != 0 ) && (pswrd.length != 0)){
            return true
        }
   
    
        var alertView = UIAlertController(title: "Missing Information", message: "Make sure you fill out all of the information!", preferredStyle: UIAlertControllerStyle.Alert)
        alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertView, animated: true, completion: nil)
        return false
        
    }
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logInViewController(logInController: PFLogInViewController!, didFailToLogInWithError error: NSError!) {
        println("Login failed")
    }
    
    func logInViewControllerDidCancelLogIn(logInController: PFLogInViewController!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, shouldBeginSignUp info: [NSObject : AnyObject]!) -> Bool {
        var informationComplete : Bool = true
        var newInfo :NSDictionary = info
        for key in info{
            var field = info[key.0] as NSString?
            if(field?.length == 0 ){
                informationComplete = false
                break
            }
            
        }
        
        if(!informationComplete){
            var alertView = UIAlertController(title: "Missing Information", message: "Make sure you fill out all of the information!", preferredStyle: UIAlertControllerStyle.Alert)
            alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertView, animated: true, completion: nil)
        }
        
        return informationComplete
        
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didSignUpUser user: PFUser!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController!, didFailToSignUpWithError error: NSError!) {
        println("Signup failed")
    }
    
    func signUpViewControllerDidCancelSignUp(signUpController: PFSignUpViewController!) {
        println("User dismissed the signup view controller")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

