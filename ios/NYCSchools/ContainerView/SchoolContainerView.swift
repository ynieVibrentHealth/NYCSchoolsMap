//
//  SchoolContainerView.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

protocol SchoolViewInput {
    func display(_ state:SchoolFunctions.State)
}

class SchoolContainerView:UIViewController, ViewControllerShowsError {
    public var output:SchoolInteractorInput?
    public var router:SchoolRouter?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let request = SchoolFunctions.Request.RetrieveSchools
        output?.handle(request)
    }
    
    fileprivate lazy var schoolListView:SchoolAddressView = {
        let schoolList = SchoolAddressView()
        schoolList.scrollAction = { [weak self] (schools:[SchoolViewModel]) -> Void in
            self?.mapView.scrollTo(schools: schools)
        }
        
        schoolList.showSchoolDetailsAction = { [weak self] (schoolModel:SchoolViewModel) -> Void in
            self?.router?.navigate(to: .SchoolDetailsView)
        }
        self.view.addSubview(schoolList)
        return schoolList
    }()
    
    fileprivate lazy var mapView:SchoolMapView = {
        let mapView = SchoolMapView()
        self.view.addSubview(mapView)
        return mapView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "NYC High Schools"
    }
    
    override func viewWillLayoutSubviews() {
        mapView.snp.updateConstraints { (make) in
            make.leading.trailing.top.equalTo(self.view)
            make.height.equalTo(self.view).multipliedBy(0.4)
        }
        
        schoolListView.snp.updateConstraints { (make) in
            make.top.equalTo(mapView.snp.bottom)
            make.leading.trailing.bottom.equalTo(self.view)
        }
        super.viewWillLayoutSubviews()
    }
}

extension SchoolContainerView:SchoolViewInput {
    func display(_ state: SchoolFunctions.State) {
        switch state {
        case .School(let schools):
            DispatchQueue.main.async { [weak self] in
                self?.schoolListView.schoolModels = schools
                self?.mapView.configure(with: schools)
            }
        case .showError(let errorDescription):
            showError(with: errorDescription)
        default:
            break
        }
    }
}
