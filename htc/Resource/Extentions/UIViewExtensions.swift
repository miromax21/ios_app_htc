//
//  UIViewExtensions.swift
//  htc
//
//  Created by Princess Max on 09.03.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import UIKit

extension UIView {
    
    func addShadowAndRounderCorners() {
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
    }
    
}
