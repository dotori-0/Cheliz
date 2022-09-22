//
//  BaseViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    // MARK: - Properties
    let backgroundImageView = UIImageView().then {
        $0.image = .background
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setConstraints()
        setActions()
    }
    
    func setUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
    }
    
    func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setActions() { }
}
