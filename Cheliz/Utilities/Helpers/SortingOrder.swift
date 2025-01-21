//
//  SortingOrder.swift
//  Cheliz
//
//  Created by SC on 2022/09/20.
//

import UIKit

enum SortingOrder: Int {
    case oldestToNewest
    case newestToOldest
    case alphabetical
    case reverseAlphabetical
    
    var state: UIMenuElement.State {
        if UserDefaults.sortingOrder == self.rawValue {
            return .on
        } else {
            return .off
        }
    }
}
