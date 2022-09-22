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
//        switch self {
//            case .oldestToNewest:
//                if UserDefaultsHelper.standard.sortingOrder == self.rawValue {
//                    return .on
//                } else {
//                    return .off
//                }
//            case .newestToOldest:
//                <#code#>
//            case .alphabetical:
//                <#code#>
//            case .reverseAlphabetical:
//                <#code#>
//        }
        if UserDefaultsHelper.standard.sortingOrder == self.rawValue {
            return .on
        } else {
            return .off
        }
    }
}
