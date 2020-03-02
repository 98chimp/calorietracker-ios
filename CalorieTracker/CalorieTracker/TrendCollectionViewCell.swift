//
//  TrendCollectionViewCell.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-29.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class TrendCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var totalCaloriesView: TotalCaloriesView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: nil)
    }
    
    func configure(with trendPoint: TrendPoint?) {
        totalCaloriesView.trendPoint = trendPoint
    }
}
