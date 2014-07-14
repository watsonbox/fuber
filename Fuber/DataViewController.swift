//
//  DataViewController.swift
//  Fuber
//
//  Created by Howard Wilson on 10/07/2014.
//  Copyright (c) 2014 Howard Wilson. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
                            
    @IBOutlet var dataLabel: UILabel
    var dataObject: AnyObject?
    var rootViewController: RootViewController?
    @IBOutlet var mealImage: UIImageView

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let obj: PFObject = dataObject as? PFObject {
            self.dataLabel!.text = obj["name"].description
            var image = obj["image"].description
            self.mealImage.image = UIImage(named: "Images/\(image)")
        } else {
            self.dataLabel!.text = ""
            self.mealImage.image = nil
        }
    }

    @IBAction func orderMeal(sender: AnyObject) {
        if (PFUser.currentUser()) {
            let paymentViewController = storyboard.instantiateViewControllerWithIdentifier("PaymentViewController") as PaymentViewController
            presentViewController(paymentViewController, animated: true, completion: nil)
        } else {
            // When not logged in, show the login screen
            rootViewController!.backToHomePage()
        }
    }
}
