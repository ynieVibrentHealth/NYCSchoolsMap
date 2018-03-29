//
//  SchoolSATScoresView.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/13/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SchoolSATScoresView:UIViewController, ViewControllerShowsError {
    fileprivate lazy var mapView:SchoolMapView = {
        let mapView = SchoolMapView()
        self.view.addSubview(mapView)
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SAT Score"
    }
    
    override func viewWillLayoutSubviews() {
        mapView.snp.updateConstraints { (make) in
            make.leading.trailing.top.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.4)
        }
        super.viewWillLayoutSubviews()
    }
}

extension SchoolSATScoresView: SchoolViewInput {
    func display(_ state: SchoolFunctions.State) {
        switch state {
        case let .SATScore(SATScore):
            DispatchQueue.main.async { [weak self] in
                self?.mapView.configure(with: [SATScore])
            }
        case .showError(let errorDescription):
            showError(with: errorDescription)
        default:
            break
        }
    }
    
    
}
