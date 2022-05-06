//
//  AppDelegate.swift
//  Chart
//
//  Created by Sergey on 06.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        ChartDataWorker.shared.preparaData()
        return true
    }
}

