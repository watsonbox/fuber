//
//  PaymentViewController.swift
//  Fuber
//
//  Created by Howard Wilson on 11/07/2014.
//  Copyright (c) 2014 Howard Wilson. All rights reserved.
//

let STRIPE_PUBLISHABLE_KEY = "pk_test_oF4LKxDonsSzaUf0CuyHUsP6"

class PaymentViewController : UIViewController, STPViewDelegate, UIAlertViewDelegate {
    @IBOutlet var stripeCardView: STPView
    @IBOutlet var payButton: UIButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stripeCardView.delegate = self
        stripeCardView.key = STRIPE_PUBLISHABLE_KEY
    }
    
    // Dismiss the on screen keyboard when tapping outside of the stripe card view
    @IBAction func viewTapped(sender: AnyObject) {
        stripeCardView.paymentView.resignFirstResponder()
    }
    
    // STPViewDelegate function called when card data changes with validity info
    func stripeView(view: STPView!, withCard card: PKCard!, isValid valid: Bool) {
        payButton.enabled = valid
    }
    
    @IBAction func cancel(sender: AnyObject) {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func pay(sender: AnyObject) {
        // TODO: Show progress HUD
        
        stripeCardView.createToken { (token: STPToken!, error: NSError!) in
            if (error) {
                self.hasError(error.localizedDescription)
            } else {
                self.hasToken(token)
            }
        }
    }
    
    func hasError(message: String) {
        UIAlertView(title: "Error", message: message, delegate: nil, cancelButtonTitle: "Okay").show()
    }
    
    func hasToken(token: STPToken!) {
        PFCloud.callFunctionInBackground("stripePayment", withParameters: ["token": token.tokenId, "amount": 100]) { (results: AnyObject!, error: NSError!) in
            if (error) {
                let message = error.userInfo["error"] as NSString
                self.hasError("\(message) Please try again.")
            } else {
                self.successfulPayment()
            }
        }
    }
    
    func successfulPayment() {
        UIAlertView(title: "Success", message: "Your card was successfully charged", delegate: self, cancelButtonTitle: "Okay").show()
    }
    
    // Handler for when success UIAlertView is dismissed
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}