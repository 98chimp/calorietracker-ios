//
//  TotalCaloriesView.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-29.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class TotalCaloriesView: UIView {

    @IBOutlet private var totalCaloriesLabel: LargeLabel!
    @IBOutlet private var dayLabel: UILabel?
    
    var trendPoint: TrendPoint? {
        didSet {
            totalCalories = trendPoint?.calories
            trendDate = trendPoint?.date
        }
    }
    
    var totalCalories: Double? {
        didSet {
            totalCaloriesLabel.text = String(format: "%0.f", totalCalories ?? 0)
        }
    }
    
    private var trendDate: Date? = Date() {
        didSet {
            dayLabel?.text = trendDate?.shortDateString
        }
    }
}
