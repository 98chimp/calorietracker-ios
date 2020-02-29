//
//  WhiteButton.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

@IBDesignable
class WhiteButton: UIButton {
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureButton()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureButton()
    }
    
    private func configureButton() {
        tintColor = .coreBlue
        backgroundColor = .white
        alpha = 0.75
    }
}
