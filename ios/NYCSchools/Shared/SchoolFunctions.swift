//
//  SchoolFunctions.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation

struct SchoolFunctions {
    enum Request {
        case RetrieveSchools
        case RetriveSATScores(school:SchoolViewModel)
    }
    enum Response {
        case Schools(json:Any)
        case SATScores(json:Any, schoolDbn:String)
        case HandleError(error:Error?)
    }
    enum State {
        case showError(description:String)
        case School(schools:[SchoolViewModel])
        case SATScore(SATScore:SATViewModel)
    }
}
