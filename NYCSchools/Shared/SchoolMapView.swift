//
//  SchoolMapView.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import UIKit
import SnapKit
import MapKit

class SchoolMapView:UIView {
    private var schools:[String: MKPointAnnotation] = [String: MKPointAnnotation]()
    private var annotation = MKPointAnnotation()
    
    public var shouldShowHPO:Bool = false
    
    fileprivate lazy var mapView:MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.mapType = MKMapType.standard
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsTraffic = false
        self.addSubview(mapView)
        return mapView
    }()
    
    fileprivate lazy var dividerLine:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.gray
        self.addSubview(view)
        return view
    }()
    
    override func updateConstraints() {
        mapView.snp.updateConstraints { (make) in
            let expectedHeight = UIScreen.main.bounds.height * 0.4
            make.top.leading.trailing.equalTo(self).priority(999)
            make.height.equalTo(expectedHeight).priority(999)
        }
        
        dividerLine.snp.updateConstraints { (make) in
            make.leading.trailing.equalTo(self).inset(15).priority(999)
            make.bottom.equalTo(self)
            make.height.equalTo(1)
        }
        super.updateConstraints()
    }

    public func configure(with schoolModels:[SchoolLocationModel]) {
        var sites = [String: MKPointAnnotation]()
        let arrSchools = schoolModels.map { (schoolModel) -> MKAnnotation? in
            guard let strLatitude = schoolModel.latitude,
                let strLongitude = schoolModel.longitude,
                let latitude = Double(strLatitude),
                let longitude = Double(strLongitude) else {return nil}
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = schoolModel.schoolName
            mapView.addAnnotation(annotation)
            sites[schoolModel.dbn] = annotation
            return annotation
        }.flatMap({$0})
        self.schools = sites
        mapView.showAnnotations(arrSchools, animated: true)
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    public func scrollTo(schools:[SchoolLocationModel]) {
        let locations = schools.map { (schoolModel) -> MKAnnotation? in
            guard let strLatitude = schoolModel.latitude,
                let strLongitude = schoolModel.longitude,
                let latitude = Double(strLatitude),
                let longitude = Double(strLongitude) else {return nil}
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = schoolModel.schoolName
            return annotation
        }.flatMap({$0})
        mapView.removeAnnotations(mapView.annotations)
        mapView.showAnnotations(locations, animated: true)
    }
}

extension SchoolMapView:MKMapViewDelegate {
    func selectAnnotation(_ duration: TimeInterval) {
        self.superview?.bringSubview(toFront: self)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let view = view as? CircleAnnotationView {
            view.selectAnnotation(0.3)
            if let annotation = view.annotation {
                mapView.setCenter(annotation.coordinate, animated: true)
            }
        }
    }
    
}
