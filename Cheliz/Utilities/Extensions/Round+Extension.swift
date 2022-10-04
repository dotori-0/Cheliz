//
//  Round+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/10/04.
//

import UIKit

extension UIView {
    func round(clipsToBounds: Bool) {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        self.clipsToBounds = clipsToBounds
    }
}
