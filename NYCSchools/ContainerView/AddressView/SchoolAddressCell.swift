//
//  SchoolAddressCell.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import SnapKit
import UIKit

class SchoolAddressCell:UITableViewCell {
    static let reuseID = "SchoolAddressCellReuseId"
    
    fileprivate lazy var displayOrderLabel:UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var nameLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var addressLabel:UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var cityLabel:UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        self.contentView.addSubview(label)
        return label
    }()
    
    fileprivate lazy var numberOfStudentsLabel:UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .right
        self.contentView.addSubview(label)
        return label
    }()
    
    public func configure(with schoolModel:SchoolViewModel) {
        nameLabel.text = schoolModel.schoolName
        addressLabel.text = schoolModel.address
        cityLabel.text = schoolModel.city
        if let numberOfStudents = schoolModel.studentCount {
            numberOfStudentsLabel.text = "Total students: \(numberOfStudents)"
        } else {
            numberOfStudentsLabel.text = ""
        }
        displayOrderLabel.text = schoolModel.displayOrder
        setNeedsUpdateConstraints()
        updateConstraintsIfNeeded()
    }
    
    override func updateConstraints() {
        displayOrderLabel.snp.updateConstraints { (make) in
            make.leading.equalTo(self.contentView).inset(20)
            make.top.equalTo(self.contentView).inset(20).priority(999)
        }
        nameLabel.snp.updateConstraints { (make) in
            make.top.equalTo(self.displayOrderLabel.snp.bottom).offset(5).priority(999)
            make.leading.equalTo(displayOrderLabel)
            make.trailing.equalTo(self.contentView).inset(20)
        }
        
        addressLabel.snp.updateConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.leading.equalTo(self.nameLabel)
            make.trailing.equalTo(self.contentView)
        }
        
        cityLabel.snp.updateConstraints { (make) in
            make.top.equalTo(addressLabel.snp.bottom).offset(3)
            make.leading.equalTo(nameLabel)
            make.trailing.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView).inset(20).priority(999)
        }
        
        numberOfStudentsLabel.snp.updateConstraints { (make) in
            make.trailing.equalTo(self.contentView).inset(20)
            make.centerY.equalTo(cityLabel)
        }
        super.updateConstraints()
    }
}
