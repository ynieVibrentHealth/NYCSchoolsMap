//
//  SchoolRouter.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/13/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import React

enum SchoolDestination {
    case SchoolDetailsView
}

class SchoolRouter {
    init(viewController:UIViewController?) {
        self.viewController = viewController
    }
    fileprivate var viewController:UIViewController?
    
    public func navigate(to destination:SchoolDestination) {
        let reactController = ReactController()
        reactController.configure(with: "RootModule", and: nil)
        reactController.configureNav(with: "Test Module") {
            reactController.dismiss(animated: true)
        }
        let nav = UINavigationController(rootViewController: reactController)
        self.viewController?.present(nav, animated: true, completion: nil)
    }
}
