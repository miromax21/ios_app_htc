//
//  PupilModel.swift
//  htc
//
//  Created by Princess Max on 07.02.2019.
//  Copyright © 2019 Princess Max. All rights reserved.
//

import Foundation
struct PupilModel:  Codable {
    let id: UUID
    var name: String!
    var lastName = ""
    var gradePointAverage:Int =  0
    
    init(name:String,last_name:String?, grade_point_average:Int?) {
        id = UUID()
        self.name = name
        self.lastName = last_name ?? ""
        self.gradePointAverage = grade_point_average ?? 0
    }
    
    init(json:[String:Any]){
        id = UUID()
        self.name = json["name"] as? String ?? ""
        self.lastName  = json["lastName"] as? String ?? ""
        self.gradePointAverage = json["lastgradePointAverageName"] as? Int ?? 1
    }
}
