//
//  UserDefaultsHelper.swift
//  Cheliz
//
//  Created by SC on 2022/09/22.
//

//import Foundation
//
//final class UserDefaultsHelper {
//    private init() { }
//    
//    static let standard = UserDefaultsHelper()
//    
//    let userDefaults = UserDefaults.standard
//    
//    enum Key: String {
//        case sortingOrder, filterOption
//    }
//    
//    var sortingOrder: Int {
//        get {
//            return userDefaults.integer(forKey: Key.sortingOrder.rawValue)  // default is 0
//        }
//        set {
//            userDefaults.set(newValue, forKey: Key.sortingOrder.rawValue)
//        }
//    }
//    
//    var filterOption: Int {
//        get {
//            return userDefaults.integer(forKey: Key.filterOption.rawValue)  // default is 0
//        }
//        set {
//            userDefaults.set(newValue, forKey: Key.filterOption.rawValue)
//        }
//    }
//}
