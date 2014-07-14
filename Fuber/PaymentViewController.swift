//
//  PaymentViewController.swift
//  Fuber
//
//  Created by Howard Wilson on 11/07/2014.
//  Copyright (c) 2014 Howard Wilson. All rights reserved.
//

class PaymentViewController : UIViewController, STPViewDelegate {
    @IBOutlet var stripeCardView: STPView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stripeCardView.delegate = self
    }
    
    @IBAction func cancel(sender: AnyObject) {
        presentingViewController.dismissViewControllerAnimated(true, completion: nil)
    }
}