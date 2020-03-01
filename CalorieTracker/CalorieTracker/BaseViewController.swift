//
//  BaseViewController.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-28.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

enum DisplayMode {
    case presenting
    case presented
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
    var displayMode = DisplayMode.presenting
    var selectedIndexPath = IndexPath()
    var foods: [Food] {
        return [Food]()
    }
    var trends: [Trend] {
        return [Trend]()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        // implement in subclass
    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    func addEmptyStateLabel() {
        emptyStateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyStateLabel)
        NSLayoutConstraint.activate(
            [emptyStateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
             emptyStateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)]
        )
    }
    
    func removeEmptyStateLabel() {
        view.removeConstraints(emptyStateLabel.constraints)
        emptyStateLabel.removeFromSuperview()
    }
}
