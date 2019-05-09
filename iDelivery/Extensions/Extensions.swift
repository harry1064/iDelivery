//
//  Extensions.swift
//  iDelivery
//
//  Created by Harpreet Singh on 10/5/2019.
//  Copyright © 2019 Harpreet Singh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setBaseViewConfiguration() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }

    func addConstraintWithFormat(_ format : String, views : UIView...) {
        var viewsDictionary = [String : UIView]()
        for(index, view) in views.enumerated(){
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
