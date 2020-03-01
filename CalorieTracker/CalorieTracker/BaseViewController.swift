//
//  BaseViewController.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-28.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

enum DisplayMode {
    case presentation
    case selection
}

protocol FoodRemovable {
    func removeFoodsFromToday(_ foods: [Food])
}

extension FoodRemovable {
    func removeFoodsFromToday(_ foods: [Food]) {
        foods.forEach({ $0.isConsumedToday = false })
        PersistenceManager.shared.saveContext()
    }
}

class BaseViewController: UIViewController {

    // MARK: - Properties
    var displayMode = DisplayMode.presentation
    var foods: [Food] {
        return [Food]()
    }
    
    // MARK: - Outlets
    @IBOutlet var emptyStateLabel: LargeLabel!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        registerCells()
        configureBarButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
    }
    
    // MARK: - Helpers
    func addObservers() {
        let context = PersistenceManager.shared.conetext
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataSource), name: Notification.Name.NSManagedObjectContextDidSave, object: context)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataSource), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: context)
    }
    
    func registerCells() {
        // implement in subclasses
    }

    func configureBarButtons() {
        // implement in subclasses
    }

    @objc
    func reloadDataSource(){
        configureView()
    }

    func configureView() {
        foods.isEmpty ? addEmptyStateLabel() : removeEmptyStateLabel()
    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    private func addEmptyStateLabel() {
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateLabel)
        NSLayoutConstraint.activate(
            [emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        )
    }
    
    private func removeEmptyStateLabel() {
        view.removeConstraints(emptyStateLabel.constraints)
        emptyStateLabel.removeFromSuperview()
    }
}
