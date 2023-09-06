//
//  UsersListViewModel.swift
//  

import Foundation
import CoreData
import UIKit.UIImage

final class UsersListViewModel: ViewModelProtocol {
    typealias EntityType = User
    let backImage = UIImage(named: "backImage")
    weak var coordinator: UsersListCoordinatorProtocol?
    lazy var fetchedResultController = makeFetchedResultsController(predicate: nil)
    var userName: String?
    var sortDescriptors: [NSSortDescriptor]? {
        return [NSSortDescriptor(key: "id", ascending: true)]
    }
    
    init(userName: String) {
        self.userName = userName
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("Fetch error: \(error)")
        }
    }
    
    func fetchedResultsController() -> NSFetchedResultsController<EntityType> {
        fetchedResultController
    }
    
    func showAuthorName() -> String {
        userName ?? "None"
    }
    
    func didSelectAt(at index: Int) {
        coordinator?.showUserVC(id: Int(itemAt(at: index)!.id))
    }
    
    func exitVC() {
        coordinator?.exitVC()
    }
}
