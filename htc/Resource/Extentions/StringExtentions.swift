//
//  StringExtentions.swift
//  htc
//
//  Created by Princess Max on 09.03.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import Foundation
public extension String{
    func isValid(rexeg:String) -> Bool {
        let stringTest = NSPredicate(format:"SELF MATCHES %@", rexeg)
        return stringTest.evaluate(with: self)
    }
}
