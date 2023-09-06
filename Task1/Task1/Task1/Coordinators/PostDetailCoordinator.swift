//
//  PostDetailCoordinator.swift
//

import Foundation
import UIKit.UINavigationController
import CoreData

protocol PostDetailCoordinatorProtocol: AnyObject {
    func exitVC()
}

final class PostDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var postId: NSManagedObjectID?
    var parent: Coordinator?
    
    var navigationController: UINavigationController?
    
    func start() {
        let vc = PostDetailController(postId: postId!)
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

extension PostDetailCoordinator: PostDetailCoordinatorProtocol {
    func exitVC() {
        childDidFinish()
    }
}
