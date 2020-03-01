//
//  TotalCaloriesView.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-29.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class TotalCaloriesView: UIView {

    @IBOutlet var totalCaloriesLabel: LargeLabel!
    
    var totalCalories: Double = 0 {
        didSet {
            totalCaloriesLabel.text = String(format: "%0.f", totalCalories)
        }
    }
}
