//
//  Coordinator.swift
//

import Foundation
import UIKit.UINavigationController

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController? { get set }
    
    var parent: Coordinator? { get }
    func start()
    
    func childDidFinish()
}

extension Coordinator {
    func childDidFinish() { }
}

extension Coordinator {
    var parent: Coordinator? {
        return nil
    }
}
