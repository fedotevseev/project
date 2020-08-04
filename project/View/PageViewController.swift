//
//  PageViewController.swift
//  project
//
//  Created by Федот Евсеев on 03.08.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import UIKit

class PageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contentViewController = showViewControllerAtIndex(0) {
            setViewControllers([contentViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func showViewControllerAtIndex(_ index: Int) -> PresentationViewController? {
           guard index >= 0 else {return nil}
        
           guard let contentPageViewController = storyboard?.instantiateViewController(
               withIdentifier: "PresentationViewController") as? PresentationViewController else { return nil }
           
           return contentPageViewController
       }
    
}
