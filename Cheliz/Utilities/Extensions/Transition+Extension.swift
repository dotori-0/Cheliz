//
//  Transition+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit

extension UIViewController {
    enum TransitionStyle {
        case push
    }
    
    func transit(to viewController: UIViewController, transitionStyle: TransitionStyle) {
        switch transitionStyle {
            case .push:
                navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
