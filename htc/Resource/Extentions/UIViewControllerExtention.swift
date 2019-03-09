//
//  UIViewControllerExtention.swift
//  htc
//
//  Created by Princess Max on 07.02.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import UIKit
extension UIViewController{
    /**
     Just return the initial vc on a storyboard
     */
    static func getInstance() -> UIViewController{
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
}
