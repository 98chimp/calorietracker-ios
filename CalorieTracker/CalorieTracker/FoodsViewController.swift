//
//  FoodsViewController.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class FoodsViewController: BaseViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var foodsTableView: UITableView!
    
    // MARK: - Properties
    private var selectedFoods = [Food]()
    override var foods: [Food] {
        return displayMode == .presentation ? FoodDataSource.shared.allFoods : FoodDataSource.shared.allUconsumedFoods
    }
    
    // MARK: - Overrides
    override func reloadDataSource() {
        super.reloadDataSource()
        foodsTableView.reloadData()
    }
    
    override func registerCells() {
        super.registerCells()
        foodsTableView.register(UINib(nibName: Constants.Identifiers.Cells.foodCellNib, bundle: nil),
                                forCellReuseIdentifier: Constants.Identifiers.Cells.foodCell)
    }
    
    override func configureView() {
        super.configureView()
        foodsTableView.isHidden = foods.isEmpty
        foodsTableView.allowsMultipleSelection = displayMode == .selection
        foodsTableView.rowHeight = UITableView.automaticDimension
    }
    
    override func configureBarButtons() {
        switch displayMode {
        case .presentation:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                target: self,
                                                                action: #selector(addButtonTapped))
            
        case .selection:
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                                target: self,
                                                                action: #selector(doneButtonTapped))
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel,
                                                               target: self,
                                                               action: #selector(cancelButtonTapped))
        }
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
    @objc
    func addButtonTapped() {
        showInputScreen(for: nil)
    }
    
    @objc
    func cancelButtonTapped() {
        dismiss()
    }
    
    @objc
    func doneButtonTapped() {
        selectedFoods.forEach({ $0.isConsumedToday = true })
        PersistenceManager.shared.saveContext()
        dismiss()
    }
}

// MARK: - Helper Functions
extension FoodsViewController: FoodRemovable {
    
    private func showInputScreen(for food: Food?) {
        performSegue(withIdentifier: Constants.Identifiers.Segues.toNewFood, sender: food)
    }
    
    private func presentActionSheet(for indexPath: IndexPath) {
        let food = foods[indexPath.row]
        let alert = AlertsManager.foodLisActionsAlert
        
        if !food.isConsumedToday {
            alert.addAction(withTitle: Constants.Alerts.Titles.Actions.addFoodToToday, style: .default) { [weak self] in
                self?.addFoodsToToday([food])
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
    
    private func addFoodsToToday(_ foods: [Food]) {
        foods.forEach({ $0.isConsumedToday = true })
        PersistenceManager.shared.saveContext()
    }
    
    private func delete(_ food: Food) {
        let alert = AlertsManager.deleteFoodAlert
        
        alert.addAction(withTitle: Constants.Alerts.Titles.Actions.delete, style: .destructive) {
            PersistenceManager.shared.delete(food)
        }
        
        alert.show()
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
        
        if !food.isConsumedToday {
            let addAction = UIContextualAction(style: .normal, title: "Add to\nToday") { [weak self] (_, _, completion) in
                self?.addFoodsToToday([food])
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
            cell.accessoryType = .checkmark
            let selectedFood = foods[indexPath.row]
            selectedFoods.append(selectedFood)
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .none
        let deselectedFood = foods[indexPath.row]
        selectedFoods.removeAll(where: { $0 == deselectedFood })
    }
}
