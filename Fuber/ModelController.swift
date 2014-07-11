//
//  ModelController.swift
//  Fuber
//
//  Created by Howard Wilson on 10/07/2014.
//  Copyright (c) 2014 Howard Wilson. All rights reserved.
//

import UIKit

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */


class ModelController: NSObject, UIPageViewControllerDataSource {
    var pageData = NSArray()
    var rootViewController: RootViewController

    init(rootViewController : RootViewController) {
        self.rootViewController = rootViewController
        
        super.init()
        
        // Create the data model - build some test data for now
        var fishAndChips = PFObject(className: "Meal")
        fishAndChips["name"] = "Fish and Chips"
        fishAndChips["image"] = "fish_and_chips.jpg"
        
        var cottagePie = PFObject(className: "Meal")
        cottagePie["name"] = "Caesar Salad"
        cottagePie["image"] = "caesar_salad.jpg"
        
        pageData = [fishAndChips, cottagePie]
    }

    func viewControllerAtIndex(index: Int, storyboard: UIStoryboard) -> UIViewController? {
        // Return the data view controller for the given index.
        if (self.pageData.count == 0) || (index >= self.pageData.count + 1 || index == 0) {
            // Create a home view controller
            let homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as HomeViewController
            return homeViewController
        } else {
            // Create a new data view controller and pass suitable data.
            let dataViewController = storyboard.instantiateViewControllerWithIdentifier("DataViewController") as DataViewController
            dataViewController.dataObject = self.pageData[index-1]
            dataViewController.rootViewController = rootViewController
            return dataViewController
        }
    }

    func indexOfViewController(viewController: UIViewController) -> Int {
        // Return the index of the given data view controller.
        // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
        if (viewController is HomeViewController) {
            return 0
        } else {
            return self.pageData.indexOfObject((viewController as DataViewController).dataObject) + 1
        }
    }

    // #pragma mark - Page View Controller Data Source

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard)
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexOfViewController(viewController)
        if index == NSNotFound {
            return nil
        }
        
        index++
        if index == self.pageData.count + 1 {
            return nil
        }
        return self.viewControllerAtIndex(index, storyboard: viewController.storyboard)
    }

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> NSInteger {
        return pageData.count + 1
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> NSInteger {
        return 0
    }
}

