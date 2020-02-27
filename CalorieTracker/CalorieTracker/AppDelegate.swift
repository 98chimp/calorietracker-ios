//
//  AppDelegate.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-25.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        return true
    }
    
    private func setupAppearance() {
        UINavigationBar.appearance().tintColor = .coreBlue
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        if #available(iOS 13, *) {
            UISegmentedControl.appearance().selectedSegmentTintColor = .coreBlue
        }
        else {
            UISegmentedControl.appearance().tintColor = .coreBlue
        }
    }
}
