//
//  ReactController.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 3/29/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit
import React
import SnapKit
import RxCocoa
import RxSwift

class ReactController:UIViewController {
    fileprivate let disposeBag:DisposeBag = DisposeBag()
    private let jsCodeLocation = URL(string: "http://localhost:8081/index.bundle?platform=ios")
    fileprivate var rootView:RCTRootView?

    public func configure(with moduleName:String, and props:[NSObject : AnyObject]?) {
        guard let rootView = RCTRootView(
            bundleURL: self.jsCodeLocation,
            moduleName: moduleName,
            initialProperties: props,
            launchOptions: nil) else {return}
        self.rootView = rootView
        view.addSubview(rootView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = []
    }
    
    override func viewWillLayoutSubviews() {
        guard let rootView = rootView else {super.viewWillLayoutSubviews();return}
        rootView.snp.updateConstraints { (make) in
            make.edges.equalTo(view)
        }
        super.viewWillLayoutSubviews()
    }
    
    
    public func configureNav(with title:String, and rightButtonAction:@escaping (() -> Void)) {
        self.title = title
        let rightBarItem = UIBarButtonItem(title: "Action", style: .plain, target: nil, action: nil)
        rightBarItem.rx.tap.subscribe(onNext: { (_) in
            rightButtonAction()
        }).disposed(by: self.disposeBag)
        self.navigationItem.rightBarButtonItem = rightBarItem
    }
}
