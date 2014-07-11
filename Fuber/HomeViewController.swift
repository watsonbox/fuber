//
//  HomeViewController.swift
//  Fuber
//
//  Created by Howard Wilson on 10/07/2014.
//  Copyright (c) 2014 Howard Wilson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {

    var logInViewController = LogInViewController()
    @IBOutlet var logoImage: UIImageView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buildLoginView()
        
        // Show the login if there is no current user
        showLogin(show: !PFUser.currentUser())
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buildLoginView() {
        logInViewController.delegate = self
        
        // Configure signup controller
        var signUpViewController = PFSignUpViewController()
        signUpViewController.delegate = self
        logInViewController.signUpController = signUpViewController
        
        // Display Parse login view
        view.addSubview(logInViewController.view)
        self.addChildViewController(logInViewController)
        logInViewController.didMoveToParentViewController(self)
    }
    
    func showLogin(show : Bool = true, animate : Bool = false) {
        if (animate) {
            UIView.animateWithDuration(1, animations: { self.logInViewController.view.alpha = show ? 1 : 0 })
        } else {
            self.logInViewController.view.alpha = show ? 1 : 0
        }
    }
    
    @IBAction func logout(sender: AnyObject) {
        PFUser.logOut()
        showLogin(show: true, animate: true)
    }

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func logInViewController(logInController: PFLogInViewController!, didLogInUser user: PFUser!) {
        showLogin(show: false, animate: true)
        (logInController.view as PFLogInView).usernameField.text = ""
        (logInController.view as PFLogInView).passwordField.text = ""
    }
}
