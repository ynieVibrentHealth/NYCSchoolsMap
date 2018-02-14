//
//  SchoolSATScoreModel.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/13/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import ObjectMapper

class SATViewModel:Mappable, SchoolLocationModel {
    var schoolName:String!
    var numberOfSATTakers:String!
    var averageMathScore:String!
    var averageReadingScore:String!
    var averageWritingScore:String!
    var dbn:String!
    
    var latitude:String?
    var longitude:String?
    var city:String!
    var studentCount:String!
    var address:String!
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        schoolName <- map["school_name"]
        numberOfSATTakers <- map["num_of_sat_test_takers"]
        dbn <- map["dbn"]
        averageMathScore <- map["sat_math_avg_score"]
        averageReadingScore <- map["sat_critical_reading_avg_score"]
        averageWritingScore <- map["sat_writing_avg_score"]
    }
}

