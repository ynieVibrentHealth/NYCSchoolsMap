//
//  CircleAnnotationView.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import UIKit
import MapKit

class CircleAnnotationView : MKAnnotationView {
    static let CircleAnnotationViewIdentifier = "MapAnnotationView"
    fileprivate let scaleFactor: CGFloat = 45/60
    
    var titleLabel: UILabel = {
        var size:CGFloat = 40.0
        var titleLable = UILabel()
        titleLable.layer.borderColor = UIColor.white.cgColor;
        titleLable.layer.borderWidth = 3.0;
        titleLable.textAlignment = .center
        titleLable.layer.cornerRadius = size / 2
        titleLable.layer.borderWidth = 3.0
        titleLable.layer.masksToBounds = true
        titleLable.layer.backgroundColor = UIColor.red.cgColor
        titleLable.font = UIFont.systemFont(ofSize: 14.0)
        titleLable.textColor = UIColor.white
        titleLable.numberOfLines = 0
        titleLable.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return titleLable
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(titleLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func selectAnnotation(_ duration: TimeInterval) {
        self.superview?.bringSubview(toFront: self)
        UIView.animate(withDuration: duration, animations: { () -> Void in
            self.titleLabel.transform = CGAffineTransform.identity
        })
    }
    
    func deselectAnnotation(_ duration: TimeInterval) {
        if let image = self.image {
            let offset = image.size.height / 2.0 - image.size.height / 2.0 * scaleFactor
            let transformScale = CGAffineTransform.identity.scaledBy(x: self.scaleFactor, y: self.scaleFactor)
            UIView.animate(withDuration: duration, animations: { () -> Void in
                self.titleLabel.transform = transformScale.translatedBy(x: 0, y: offset)
            })
        }
    }
}

