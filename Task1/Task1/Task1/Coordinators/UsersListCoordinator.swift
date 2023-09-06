//
//  UsersListCoordinator.swift
//

import Foundation
import UIKit.UINavigationController
import CoreData

protocol UsersListCoordinatorProtocol: AnyObject {
    func exitVC()
    func showUserVC(id: Int)
}

final class UsersListCoordinator: Coordinator {
    weak var delegate: UsersListCoordinatorProtocol?
    var childCoordinators: [Coordinator] = []
    var userName: String?
    var parent: Coordinator?
    var navigationController: UINavigationController?
    
    func start() {
        let vc = UsersListController(userName: userName!)
        vc.viewModel.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func childDidFinish() {
        if let firstIndex = parent?.childCoordinators.firstIndex(where: {($0 as AnyObject) === self}) {
            parent?.childCoordinators.remove(at: firstIndex)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension UsersListCoordinator: UsersListCoordinatorProtocol {
    func exitVC() {
        childDidFinish()
        delegate?.exitVC()
    }
    
    func showUserVC(id: Int) {
        childDidFinish()
        delegate?.showUserVC(id: id)
    }
}
