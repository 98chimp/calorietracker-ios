//
//  ThirdyDayTrendCollectionViewCell.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-29.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class ThirdyDayTrendCollectionViewCell: TrendCollectionViewCell {
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureCell()
    }
    
    private func configureCell() {
        layer.borderColor = UIColor.coreGray.cgColor
        layer.borderWidth = 1.0
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
