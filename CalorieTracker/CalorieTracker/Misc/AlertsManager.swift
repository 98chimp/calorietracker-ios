//
//  AlertsManager.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

struct AlertsManager {
    static var photoSelectionAlert: UIAlertController {
        let alert = UIAlertController(title: "", message: Constant.Alert.Message.photoSelection, preferredStyle: .actionSheet)
        alert.addCancelAction()
        return alert
    }
    
    static var foodLisActionsAlert: UIAlertController {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addCancelAction()
        return alert
    }
    
    static var deleteFoodAlert: UIAlertController {
        let alert = UIAlertController(title: Constant.Alert.Title.attention, message: Constant.Alert.Message.makeSelection, preferredStyle: .alert)
        alert.addCancelAction()
        return alert
    }
    
    static var createMockDataAlert: UIAlertController {
        let alert = UIAlertController(title: Constant.Alert.Title.createMockData, message: Constant.Alert.Message.makeSelection, preferredStyle: .alert)
        alert.addCancelAction()
        return alert
    }

    static var destroyMockDataAlert: UIAlertController {
        let alert = UIAlertController(title: Constant.Alert.Title.destroyMockData, message: Constant.Alert.Message.makeSelection, preferredStyle: .alert)
        alert.addCancelAction()
        return alert
    }
}
