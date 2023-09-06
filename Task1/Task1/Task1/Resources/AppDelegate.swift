//
//  AppDelegate.swift
//  

import UIKit
import CoreData

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
