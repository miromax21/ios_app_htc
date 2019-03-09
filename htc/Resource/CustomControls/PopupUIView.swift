//
//  PopupUIView.swift
//  htc
//
//  Created by Princess Max on 07.02.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import UIKit

class PopupUIView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.cornerRadius = 10
        
        backgroundColor = Theme.colorBackground
    }
    
}
