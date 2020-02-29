//
//  FoodsViewController.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class FoodsViewController: BaseViewController {
    
    enum DisplayMode {
        case presentation
        case selection
    }
    
    // MARK: - Outlets
    @IBOutlet weak var foodsTableView: UITableView!
    
    // MARK: - Properties
    var displayMode = DisplayMode.presentation
    override var foods: [Food] {
        return FoodDataSource.shared.allFoods
    }
    
    // MARK: - Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        configureView()
    }
    
    // MARK: - Overrides
    override func reloadDataSource() {
        
        super.reloadDataSource()
        foodsTableView.reloadData()
    }
    
    override func configureView() {
        
        super.configureView()
        foodsTableView.isHidden = foods.isEmpty
        foodsTableView.allowsMultipleSelection = displayMode == .selection
        foodsTableView.rowHeight = UITableView.automaticDimension
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == Constants.Identifiers.Segues.toNewFood {
            let destinationVC = segue.destination as? UINavigationController
            let newFoodVC = destinationVC?.viewControllers.first as? NewFoodViewController
            newFoodVC?.newFood = sender as? Food
        }
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        showInputScreen(for: nil)
    }
}

// MARK: - Helper Functions
extension FoodsViewController {
    
    private func showInputScreen(for food: Food?) {
        
        performSegue(withIdentifier: Constants.Identifiers.Segues.toNewFood, sender: food)
    }
    
    private func presentActionSheet(for indexPath: IndexPath) {
        
        let food = foods[indexPath.row]
        let alert = AlertsManager.foodLisActionsAlert
        
        if canAddFoodToToday(food) {
            alert.addAction(withTitle: Constants.Alerts.Titles.Actions.addFoodToToday, style: .default) { [weak self] in
                self?.addFoodToToday(food)
            }
        }
        
        alert.addAction(withTitle: Constants.Alerts.Titles.Actions.editFood, style: .default) { [weak self] in
            self?.showInputScreen(for: food)
        }
        
        alert.addAction(withTitle: Constants.Alerts.Titles.Actions.deleteFood, style: .destructive) { [weak self] in
            self?.delete(food)
        }
        
        alert.show()
    }
    
    private func addFoodToToday(_ food: Food) {
        
        food.consumptionDates.append(Date())
        PersistenceManager.shared.saveContext()
    }
    
    private func delete(_ food: Food) {
        
        let alert = AlertsManager.deleteFoodAlert
        
        alert.addAction(withTitle: Constants.Alerts.Titles.Actions.delete, style: .destructive) {
            PersistenceManager.shared.delete(food)
        }
        
        alert.show()
    }
    
    private func canAddFoodToToday(_ food: Food) -> Bool {
        
        if food.consumptionDates.isEmpty {
            return true
        }
        
        if let lastConsumptionDate = food.consumptionDates.last,
            !Calendar.current.isDateInToday(lastConsumptionDate) {
            return true
        }
        
        return false
    }
}

// MARK: - Table View Data Source
extension FoodsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return foods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let foodCell = tableView.dequeueReusableCell(withIdentifier: Constants.Identifiers.Cells.foodCell, for: indexPath) as? FoodTableViewCell else { return UITableViewCell() }
        foodCell.configure(with: foods[indexPath.row])
        
        return foodCell
    }
}

// MARK: - Table View Delegate
extension FoodsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let food = foods[indexPath.row]
        
        if canAddFoodToToday(food) {
            let addAction = UIContextualAction(style: .destructive, title: "Add to\nToday") { [weak self] (_, _, completion) in
                self?.addFoodToToday(food)
                completion(true)
            }
            
            addAction.backgroundColor = .coreBlue
            return UISwipeActionsConfiguration(actions: [addAction])
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let food = foods[indexPath.row]
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (_, _, completion) in
            self?.delete(food)
            completion(true)
        }
        
        let editAction = UIContextualAction(style: .destructive, title: "Edit") { [weak self] (_, _, completion) in
            self?.showInputScreen(for: food)
            completion(true)
        }
        
        deleteAction.backgroundColor = .coreRed
        editAction.backgroundColor = .coreGray
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch displayMode {
        case .presentation:
            tableView.deselectRow(at: indexPath, animated: false)
            presentActionSheet(for: indexPath)
            
        case .selection:
            guard let cell = tableView.cellForRow(at: indexPath) else { return }
            cell.accessoryType = cell.isSelected ? .checkmark : .none
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
    }
}
