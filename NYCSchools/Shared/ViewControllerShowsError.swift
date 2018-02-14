//
//  ViewControllerShowsError.swift
//  NYCSchools
//
//  Created by Yuchen Nie on 2/13/18.
//  Copyright © 2018 Yuchen Nie. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerShowsError {
    func show500Error()
    func showError(with message:String)
}

extension ViewControllerShowsError where Self:UIViewController {
    func show500Error() {
        showErrorLabel(with: "Internal Server Error")
    }
    
    func showError(with message:String) {
        showErrorLabel(with: message)
    }
    
    private func showErrorLabel(with errorText:String) {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 20, height: 0)
        self.view.addSubview(label)
        label.backgroundColor = .lightGray
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        UIView.animate(withDuration: 0.2, animations: {
            label.text = errorText
            let expectedHeight = errorText.calculateLabelHeight(width: self.view.frame.size.width, font: UIFont.systemFont(ofSize: 14))
            label.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: expectedHeight + 5)
        }) { (finished) in
            if finished {
                if #available(iOS 10.0, *) {
                    Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { _ in
                        UIView.animate(withDuration: 0.3, animations: {
                            label.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)
                        }, completion: { (finished) in
                            if finished {
                                label.removeFromSuperview()
                            }
                        })
                    }
                } else {
                    label.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 0)
                }
            }
        }
    }
}
extension String {
    func calculateLabelHeight(width:CGFloat, font:UIFont) -> CGFloat{
        let constrainedSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [ NSAttributedStringKey.font: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (self as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return ceil(bounds.height)
    }
}

