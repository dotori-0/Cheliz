//
//  DateFormatterHelper.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import Foundation

class DateFormatterHelper {
    private init() { }
    
    static let standard = DateFormatter()
    
    static func setFormatter() {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy.MM.dd_HH:mm:ss"
        standard.dateFormat = "yyyy.MM.dd_HH:mm:ss"
        print(standard.string(from: Date.now))
    }
}
