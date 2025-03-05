//
//  MediaType.swift
//  Cheliz
//
//  Created by SC on 2022/09/16.
//

import Foundation

enum MediaType: Int {
    case movie
    case tv
    
    var string: String {
        get {
            return "\(self)"
        }
    }
}
