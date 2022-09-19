//
//  Alert+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/19.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String, allowsCancel: Bool = false, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: Notice.ok, style: .default, handler: handler)
        alert.addAction(ok)
        
        if allowsCancel {
            let cancel = UIAlertAction(title: Notice.cancel, style: .cancel)
            alert.addAction(cancel)
        }
        
        present(alert, animated: true)
    }
}
