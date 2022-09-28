//
//  UIFont+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

extension UIFont {
    enum Style: String {
        case Light, Regular, Bold
    }
    
    static func dongle(style: Style, size: CGFloat) -> UIFont {
        return UIFont(name: "Dongle-\(style)", size: size)!
    }
    
    static func hyemin(style: Style, size: CGFloat) -> UIFont {
        return UIFont(name: "IMHyemin-\(style)", size: size)!
    }
    
    static func barunpen(style: Style, size: CGFloat) -> UIFont {
        let fontName = style == .Regular ? "NanumBarunpen" : "NanumBarunpen-\(style)"
        return UIFont(name: fontName, size: size)!
    }
    
    static func meringue(size: CGFloat) -> UIFont {
        return UIFont(name: "BaMeringue", size: size)!
    }
}

//Dongle-Regular
//Dongle-Light
//Dongle-Bold

//IMHyemin-Regular
//IMHyemin-Bold

//NanumBarunpen
//NanumBarunpen-Bold

//BaMeringue



//    let titleLabel = UILabel().then {
////        label.font = .systemFont(ofSize: 20)
////        label.font = UIFont.dongle(style: .Regular, size: 30)
//
////        $0.font = UIFont.hyemin(style: .Bold, size: 16)  // == meringue 19  == barunpen 18.5
////        $0.font = UIFont.hyemin(style: .Regular, size: 16)  // == meringue 19
//
////        $0.font = UIFont.barunpen(style: .Bold, size: 18.5)
////        $0.font = UIFont.barunpen(style: .Regular, size: 18.5)
//
//        $0.font = UIFont.meringue(size: 18)
//    }


//    let releaseYearLabel = UILabel().then {
////        $0.font = .systemFont(ofSize: 20)
////        $0.font = UIFont.dongle(style: .Regular, size: 12)
//
////        $0.font = UIFont.hyemin(style: .Bold, size: 12)  // == meringue 14
////        $0.font = UIFont.hyemin(style: .Regular, size: 12)  // == meringue 14
//
////        $0.font = UIFont.barunpen(style: .Bold, size: 14)
////        $0.font = UIFont.barunpen(style: .Regular, size: 14)
//
//        $0.font = UIFont.meringue(size: 14)
//        $0.textColor = .systemGray
//    }


//    let mediaTypeLabel = UILabel().then {
////        $0.font = .systemFont(ofSize: 20)
//
////        $0.font = UIFont.hyemin(style: .Bold, size: 12)
////        $0.font = UIFont.hyemin(style: .Regular, size: 12)
//
////        $0.font = UIFont.barunpen(style: .Bold, size: 14)
////        $0.font = UIFont.barunpen(style: .Regular, size: 14)
//
//        $0.font = UIFont.meringue(size: 14)
//        $0.textColor = .systemGray
//    }


//    let backupInfoLabel = UILabel().then {
//        $0.text = Notice.backupAndRestoreInfo
//        $0.numberOfLines = 0
//        $0.textAlignment = .left
//        $0.font = .meringue(size: 13)
////        $0.font = .systemFont(ofSize: 13)
//        $0.textColor = .secondaryLabel
////        $0.backgroundColor = .systemMint
//        $0.sizeToFit()
//    }
