//
//  LargeLabel.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

@IBDesignable
class LargeLabel: UILabel {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureLabel()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureLabel()
    }

    private func configureLabel() {
        textColor = .coreGray
        font = UIFont.systemFont(ofSize: 40, weight: .ultraLight)
    }
}
