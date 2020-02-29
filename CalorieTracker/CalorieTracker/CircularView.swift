//
//  CircularView.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

@IBDesignable
class CircularView: UIView {
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureView()
    }
    
    private func configureView() {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.coreGray.cgColor
        layer.cornerRadius = bounds.width/2.0
        clipsToBounds = true
    }
}
