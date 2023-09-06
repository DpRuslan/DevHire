//
//  MainCoordinator.swift
//

import Foundation
import UIKit.UINavigationController
import CoreData

protocol MainCoordinatorProtocol: AnyObject {
    func showCommentsVC(id: NSManagedObjectID)
    func showUsersList(userName: String)
}

final class MainCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var postDetailCoordinator: PostDetailCoordinator?
    var usersListCoordinator: UsersListCoordinator?
    let vc = DefaultUserController(userId: 1)
    
    var navigationController: UINavigationController?
    
    func start() {
        vc.viewModel.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator: MainCoordinatorProtocol {
    func showCommentsVC(id: NSManagedObjectID) {
        let postDetailCoordinator = PostDetailCoordinator()
        self.postDetailCoordinator = postDetailCoordinator
        postDetailCoordinator.navigationController = navigationController
        postDetailCoordinator.parent = self
        postDetailCoordinator.postId = id
        childCoordinators.append(postDetailCoordinator)
        postDetailCoordinator.start()
    }
    
    func showUsersList(userName: String) {
        let usersListCoordinator = UsersListCoordinator()
        self.usersListCoordinator = usersListCoordinator
        usersListCoordinator.navigationController = navigationController
        usersListCoordinator.parent = self
        usersListCoordinator.delegate = self
        usersListCoordinator.userName = userName
        childCoordinators.append(usersListCoordinator)
        usersListCoordinator.start()
    }
}

extension MainCoordinator: UsersListCoordinatorProtocol {
    func exitVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func showUserVC(id: Int) {
        vc.viewModel.userId = id
        vc.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
}
