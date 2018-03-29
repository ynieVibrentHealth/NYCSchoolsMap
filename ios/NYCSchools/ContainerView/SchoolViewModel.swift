//
//  SchoolViewModel.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import ObjectMapper

class SchoolViewModel:Mappable, SchoolLocationModel {
    var schoolName:String!
    var city:String!
    var studentCount:String!
    var address:String!

    var dbn:String!
    
    var latitude:String?
    var longitude:String?
    var displayOrder:String!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        schoolName <- map["school_name"]
        latitude <- map["latitude"]
        longitude <- map["longitude"]
        city <- map["city"]
        studentCount <- map["total_students"]
        address <- map["primary_address_line_1"]
        dbn <- map["dbn"]
    }
}
