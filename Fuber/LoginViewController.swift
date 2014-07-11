//
//  LoginViewController.swift
//  Fuber
//
//  Created by Howard Wilson on 10/07/2014.
//  Copyright (c) 2014 Howard Wilson. All rights reserved.
//

class LogInViewController: PFLogInViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Custom styling
        self.logInView.frame = CGRectMake(0, -2, self.logInView.bounds.size.width, self.logInView.bounds.size.height + 22)
        self.logInView.dismissButton.hidden = true
        self.logInView.logo = UIImageView(image: UIImage(named: "Images/logo.png"))
    }
    
    override func viewDidLayoutSubviews() {
        // Set logo to fixed position from top of page
        var loginLogo = (view as PFLogInView).logo
        loginLogo.frame = CGRectMake(loginLogo.frame.origin.x, 122, loginLogo.frame.width, loginLogo.frame.height)
    }
}