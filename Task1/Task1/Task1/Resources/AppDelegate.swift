//
//  AppDelegate.swift
//  

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    static var coreDataStack = CoreDataStack(modelName: "Task1")
    var window: UIWindow?
    var navVC: UINavigationController?
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if checkForEmptyCoreData() {
            showLoading()
            doRequests()
        } else {
            dataIsReady()
        }
        
        return true
    }
}

// MARK: Show spinner while data is loading
extension AppDelegate {
    func showLoading() {
        let loadingController = LoadingController()
        window?.rootViewController = loadingController
        window?.makeKeyAndVisible()
    }
}

// MARK: Trigger that data is ready for user
extension AppDelegate {
    func dataIsReady() {
        navVC = UINavigationController()
        window?.rootViewController = navVC
        coordinator = MainCoordinator()
        coordinator!.navigationController = navVC
        window?.makeKeyAndVisible()
        
        coordinator!.start()
    }
}
