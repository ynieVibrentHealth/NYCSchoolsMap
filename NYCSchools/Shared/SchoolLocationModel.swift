//
//  SchoolLocationModel.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/13/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation

protocol SchoolLocationModel {
    var latitude:String? {get set}
    var longitude:String? {get set}
    var schoolName:String! {get}
    var dbn:String! {get}
}
