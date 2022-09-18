//
//  Alert+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/19.
//

import UIKit

extension UIViewController {
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: Notice.ok, style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true)
    }
}
