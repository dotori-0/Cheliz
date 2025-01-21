//
//  UserDefaults+Extension.swift
//  Cheliz
//
//  Created by SC on 1/21/25.
//

import Foundation

extension UserDefaults {
    enum Key: String {
        case sortingOrder, filterOption
    }
    
    // MARK: - UserDefaults
    @UserDefault(key: Key.sortingOrder.rawValue, defaultValue: Int.zero)
    static var sortingOrder: Int
    
    @UserDefault(key: Key.filterOption.rawValue, defaultValue: Int.zero)
    static var filterOption: Int
}
