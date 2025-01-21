//
//  FilterOption.swift
//  Cheliz
//
//  Created by SC on 2022/09/21.
//

import UIKit

enum FilterOption: Int {
    case showWatched
    case hideWatched
    
    var state: UIMenuElement.State {
        if UserDefaults.filterOption == self.rawValue {
            return .on
        } else {
            return .off
        }
    }
}
