//
//  ReusableView.swift
//  Cheliz
//
//  Created by SC on 2022/09/13.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReusableView { }
