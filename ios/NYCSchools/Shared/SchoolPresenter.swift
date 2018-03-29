//
//  SchoolPresenter.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol SchoolPresenterInput {
    func process(_ response:SchoolFunctions.Response)
}

class SchoolPresenter:SchoolPresenterInput {
    public var output:SchoolViewInput?
    
    private var schoolList:[SchoolViewModel]?
    
    func process(_ response: SchoolFunctions.Response) {
        switch response {
        case .Schools(let json):
            processJSON(with: json)
        case let .SATScores(json, schoolDbn):
            retrieveSATScores(with: json, and: schoolDbn)
        case .HandleError(let error):
            handleError(with: error)
        }
    }
    
    private func handleError(with error:Error?) {
        if let errorDesc = error?.localizedDescription {
            let state = SchoolFunctions.State.showError(description: errorDesc)
            output?.display(state)
        } else {
            let state = SchoolFunctions.State.showError(description: "Something went wrong")
            output?.display(state)
        }
    }
    
    private func retrieveSATScores(with json:Any, and schoolDbn:String) {
        guard let objectDict = getJSONArray(from: json),
        let schoolList = schoolList else {handleError(with: nil);return}
        let SATScores = Mapper<SATViewModel>().mapArray(JSONArray: objectDict)
        
        let selectedSchoolist = schoolList.filter { (schoolViewModel) -> Bool in
            return schoolViewModel.dbn == schoolDbn
        }
        let selectedSATScoreList = SATScores.filter { (SATScore) -> Bool in
            return SATScore.dbn == schoolDbn
        }
        
        guard let selectedSchool = selectedSchoolist.first, let selectedSAT = selectedSATScoreList.first else {return}
        selectedSAT.address = selectedSchool.address
        selectedSAT.latitude = selectedSchool.latitude
        selectedSAT.longitude = selectedSchool.longitude
        selectedSAT.city = selectedSchool.city
        selectedSAT.studentCount = selectedSchool.studentCount
    }
    
    private func processJSON(with json:Any){
        guard let objectDict = getJSONArray(from: json) else {handleError(with: nil);return}
        let schools = Mapper<SchoolViewModel>().mapArray(JSONArray: objectDict)
        for (index, school) in schools.enumerated() {
            school.displayOrder = "\(index + 1)"
        }
        schoolList = schools
        let state = SchoolFunctions.State.School(schools: schools)
        output?.display(state)
    }
    
    private func getJSONArray(from json:Any) -> [[String : Any]]? {
        var object:Any
        if let json = json as? Data,
            let parsedJSON = try? JSONSerialization.jsonObject(with: json, options: .allowFragments){
            object = parsedJSON
        } else {
            object = json
        }
        guard let objectDict = object as? [[String : Any]] else {return nil}
        return objectDict
    }
}
