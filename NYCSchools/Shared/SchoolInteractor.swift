//
//  SchoolInteractor.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import Alamofire

protocol SchoolInteractorInput {
    func handle(_ request:SchoolFunctions.Request)
}

class SchoolInteractor:SchoolInteractorInput {
    public var output:SchoolPresenterInput?
    
    func handle(_ request: SchoolFunctions.Request) {
        switch request {
        case .RetrieveSchools:
            retrieveSchools()
        case .RetriveSATScores(let school):
            retrieveSATScore(for: school.dbn)
        }
    }
    
    private func retrieveSchools() {
        guard let requestURL = URL(string: "https://data.cityofnewyork.us/resource/97mf-9njv.json") else {handleError(error: nil); return}
        Alamofire.request(requestURL).responseJSON(queue: nil, options: .allowFragments) { [weak self] (dataResponse) in
            guard let _self = self else {return}
            switch dataResponse.result {
            case .success(let value):
                let response = SchoolFunctions.Response.Schools(json: value)
                _self.output?.process(response)
            case .failure(let error):
                _self.handleError(error: error)
            }
        }
        
    }
    
    private func retrieveSATScore(for schoolId:String) {
        guard let requestURL = URL(string: "https://data.cityofnewyork.us/resource/734v-jeq5.json") else {handleError(error: nil); return}
        Alamofire.request(requestURL).responseJSON(queue: nil, options: .allowFragments) { [weak self] (dataResponse) in
            guard let _self = self else {return}
            switch dataResponse.result {
            case .success(let value):
                let response = SchoolFunctions.Response.SATScores(json: value, schoolDbn: schoolId)
                _self.output?.process(response)
            case .failure(let error):
                _self.handleError(error: error)
            }
        }
    }
    
    private func handleError(error:Error?) {
        let response = SchoolFunctions.Response.HandleError(error: error)
        output?.process(response)
    }
}
