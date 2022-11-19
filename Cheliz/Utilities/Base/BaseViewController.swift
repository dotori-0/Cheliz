//
//  BaseViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

import SnapKit
import Toast

class BaseViewController: UIViewController {
    // MARK: - Properties
    let backgroundImageView = UIImageView().then {
        $0.image = .background
    }
    
    var toastStyle = ToastStyle()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setConstraints()
        setActions()
    }
    
    // MARK: - Design Methods
    func setUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(backgroundImageView)
        
        toastStyle.messageFont = .meringue(size: 15)
    }
    
    func setConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Action Methods
    func setActions() { }
}
