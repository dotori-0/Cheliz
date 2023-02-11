//
//  MediaPassableButton.swift
//  Cheliz
//
//  Created by SC on 2022/09/21.
//

import UIKit

class MediaPassableButton: UIButton {
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
