//
//  SchoolAddressView.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/7/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SchoolAddressView:UIView {
    public var schoolModels:[SchoolViewModel] = [SchoolViewModel]() {
        didSet {
            schoolTable.reloadData()
        }
    }
    
    public var scrollAction:((_ addressModels:[SchoolViewModel]) -> Void)?
    public var showSchoolDetailsAction:((_ schoolModel:SchoolViewModel) -> Void)?
    
    fileprivate lazy var schoolTable:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        tableView.register(SchoolAddressCell.self, forCellReuseIdentifier: SchoolAddressCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        self.addSubview(tableView)
        return tableView
    }()
    
    override func layoutSubviews() {
        schoolTable.snp.updateConstraints { (make) in
            make.edges.equalTo(self)
        }
        super.layoutSubviews()
    }
}

extension SchoolAddressView: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let schoolCell = tableView.dequeueReusableCell(withIdentifier: SchoolAddressCell.reuseID, for: indexPath) as? SchoolAddressCell else { return UITableViewCell()}
        let model = schoolModels[indexPath.row]
        schoolCell.configure(with: model)
        return schoolCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let school = self.schoolModels[indexPath.row]
        showSchoolDetailsAction?(school)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let visibleIndexPaths = schoolTable.indexPathsForVisibleRows else {return}
        let visibleSchools = visibleIndexPaths.map { (indexPath) -> SchoolViewModel in
            return schoolModels[indexPath.row]
        }
        scrollAction?(visibleSchools)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {

    }
}
