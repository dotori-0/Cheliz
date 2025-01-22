//
//  AppFont.swift
//  Cheliz
//
//  Created by SC on 1/21/25.
//

import Foundation

enum AppFont: String, CaseIterable {
    case system = "System"
    case meringue = "Meringue"
    
    var title: String {
        switch self {
            case .system:
                return "시스템 폰트"
            case .meringue:
                return "Ba머랭머랭"
        }
    }
}
