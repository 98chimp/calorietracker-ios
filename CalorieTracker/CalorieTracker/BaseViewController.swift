//
//  BaseViewController.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-28.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var foods: [Food] {
        return [Food]()
    }
    
    @IBOutlet var emptyStateLabel: LargeLabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureView()
    }
    
    func addObservers() {
        let context = PersistenceManager.shared.conetext
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataSource), name: Notification.Name.NSManagedObjectContextDidSave, object: context)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataSource), name: Notification.Name.NSManagedObjectContextObjectsDidChange, object: context)
    }

    @objc
    func reloadDataSource(){
        configureView()
    }

    func configureView() {
        foods.isEmpty ? addEmptyStateLabel() : removeEmptyStateLabel()
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
