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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!PFUser.currentUser()) {
            buildLoginView()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)    }

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
    
    func showLogin(show : Bool = true) {
        UIView.animateWithDuration(1, animations: { self.logInViewController.view.alpha = show ? 1 : 0 })
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
        showLogin(show: false)
    }
}
