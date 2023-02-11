//
//  MediaPassableStepper.swift
//  Cheliz
//
//  Created by SC on 2022/10/02.
//

import UIKit

class MediaPassableStepper: UIStepper {
    // MARK: - Properties
    var media: Media?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
