//
//  TodayViewController.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class TodayViewController: BaseViewController {

    @IBOutlet weak var todayTableView: UITableView!
    @IBOutlet weak var totalCaloriesView: TotalCaloriesView!
    
    override var foods: [Food] {
        return FoodDataSource.shared.todayFoods
    }
    
    // MARK: - Overrides
    override func reloadDataSource() {
        super.reloadDataSource()
        todayTableView.reloadData()
    }
    
    override func configureView() {
        super.configureView()
        todayTableView.isHidden = foods.isEmpty
        todayTableView.allowsSelection = false
        todayTableView.rowHeight = UITableView.automaticDimension
        totalCaloriesView.totalCalories = FoodDataSource.shared.totalTodayCalories
    }
    
    override func registerCells() {
        super.registerCells()
        todayTableView.register(UINib(nibName: Constants.Identifiers.Cells.foodCellNib, bundle: nil),
                                forCellReuseIdentifier: Constants.Identifiers.Cells.foodCell)
    }
    
    override func configureBarButtons() {
        switch displayMode {
        case .presentation:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                target: self,
                                                                action: #selector(addButtonTapped))
            
        case .selection:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                               target: self,
                                                               action: #selector(cancelButtonTapped))
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Identifiers.Segues.toFoods {
            let destinationVC = segue.destination as? UINavigationController
            let foodsVC = destinationVC?.viewControllers.first as? FoodsViewController
            foodsVC?.displayMode = .selection
        }
    }
    
    // MARK: - Actions
    @objc
    func cancelButtonTapped() {
        dismiss()
    }
    
    @objc
    func addButtonTapped() {
        performSegue(withIdentifier: Constants.Identifiers.Segues.toFoods, sender: nil)
    }
}

extension TodayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let foodCell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.Cells.foodCell, for: indexPath) as? FoodTableViewCell else { return UITableViewCell() }
        foodCell.configure(with: foods[indexPath.row])
        
        return foodCell
    }
}

extension TodayViewController: UITableViewDelegate, FoodRemovable {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let food = foods[indexPath.row]
        let addAction = UIContextualAction(style: .normal, title: "Remove") { [weak self] (_, _, completion) in
            self?.removeFoodsFromToday([food])
            completion(true)
        }
        
        addAction.backgroundColor = .coreOrange
        return UISwipeActionsConfiguration(actions: [addAction])
    }
}
