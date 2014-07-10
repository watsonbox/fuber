//
//  HomeViewController.swift
//  Fuber
//
//  Created by Howard Wilson on 10/07/2014.
//  Copyright (c) 2014 Howard Wilson. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, PFLogInViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display Parse login view
        var logInViewController = PFLogInViewController()
        logInViewController.delegate = self
        view.addSubview(logInViewController.view)
        self.addChildViewController(logInViewController)
        logInViewController.didMoveToParentViewController(self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
