//
//  ValidationEnums.swift
//  htc
//
//  Created by Princess Max on 09.02.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import Foundation
extension String{
    func isValid(rexeg:String) -> Bool {
        let stringTest = NSPredicate(format:"SELF MATCHES %@", rexeg)
        return stringTest.evaluate(with: self)
    }
}
enum ValidationTypeEnum {
    case name
    case lastName
    case gradePointAverage
}
enum RegExEnum: String {
    case name = "^[A-ZА-я]+[a-zа-я]*$"
    case gradePointAverage = "[0-5]{1}"
}

struct ValidationObject {
    var type: RegExEnum
    var inputValue: String
    var lable : String = ""
    var required: Bool = true
    init (type: RegExEnum, inputValue: String, required : Bool? = false, lable: String? = ""){
        self.type = type
        self.inputValue = inputValue
        self.lable = (lable != "") ? lable! : "\(type)"
        self.required = required ?? false
    }
}
struct InvalideObject {
    var key: String
    var errorMrssage: String
}
class Validation: NSObject {
    
    public static let shared = Validation()
   
    func validate(values:ValidationObject...) -> [InvalideObject] {
        var errors = [InvalideObject]()
        for value in values {
            if value.required && value.inputValue.isEmpty{
                  errors.append(InvalideObject(key: value.lable, errorMrssage: "can't be empty"))
            }
            else if !value.inputValue.isValid(rexeg: value.type.rawValue){
                errors.append(InvalideObject(key: value.lable, errorMrssage: "invalid"))
            }
        }
        return errors
    }
    
}
