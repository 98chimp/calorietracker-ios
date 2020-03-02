//
//  FoodTableViewCell.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-29.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class FoodTableViewCell: UITableViewCell {

    @IBOutlet weak var foodImageView: CircularImageView!
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCaloriesLabel: UILabel!
    
    override func prepareForReuse() {
        configure(with: nil)
    }
    
    func configure(with food: Food?) {
        foodNameLabel.text = food?.name
        if let food = food {
            foodImageView.image = UIImage(data: food.imageData)
            foodCaloriesLabel.text = String(format: "%.0f", food.calories)
        }
        else {
            foodImageView.image = nil
            foodCaloriesLabel.text = ""
        }
    }
}
