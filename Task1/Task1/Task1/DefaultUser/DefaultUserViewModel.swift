//
//  DefaultUserViewModel.swift
//  

import Foundation
import CoreData
import UIKit.UIImage
import Combine

final class DefaultUserViewModel: ViewModelProtocol {
    typealias EntityType = User
    var userId: Int?
    private var didTriggerEvent = false
    let usersListImage = UIImage(named: "chooseUser")
    weak var coordinator: MainCoordinatorProtocol?
    lazy var fetchedResultController = makeFetchedResultsController(predicate: nil)
    
    var sortDescriptors: [NSSortDescriptor]? {
        return [NSSortDescriptor(key: "id", ascending: true)]
    }
    
    private let eventSubject = PassthroughSubject<String, Never>()
    
    var eventPubisher: AnyPublisher<String, Never> {
        return eventSubject.eraseToAnyPublisher()
    }
    
    func eventOccured(newName: String) {
        eventSubject.send(newName)
    }
    
    init(userId: Int) {
        self.userId = userId
        do {
            try fetchedResultController.performFetch()
        } catch {
            print("Fetch error: \(error)")
        }
    }
    
    func fetchedResultsController() -> NSFetchedResultsController<EntityType> {
        fetchedResultController
    }
    
    func itemAt(at index: Int) -> Post? {
        guard let user = fetchedResultsController().fetchedObjects?.first(where: {$0.id == userId!}) else { return nil }
        
        let posts = user.posts!.allObjects as? [Post]
        let sortedPosts = sortArrayByHeightOfIds(posts!)
        
        if !didTriggerEvent {
            didTriggerEvent = true
            eventOccured(newName: user.name!)
        }
        
        return sortedPosts[index]
    }
    
    func didSelectAt(at index: Int) {
        coordinator?.showCommentsVC(id: itemAt(at: index)!.objectID)
    }
    
    func showAuthorName() -> String {
        fetchedResultController.fetchedObjects?.first(where: {$0.id == userId!})?.name ?? "None"
    }
    
    func showUsersList() {
        coordinator?.showUsersList(userName: showAuthorName())
    }
    
// MARK: Sort arrray by increasing id
    func sortArrayByHeightOfIds(_ array: [Post]) -> [Post] {
        return array.sorted { (post1, post2) -> Bool in
            return post1.id < post2.id // Sort in ascending order
        }
    }
    
// MARK: Check if user was changed
    func checkTrigger() {
        if didTriggerEvent {
            didTriggerEvent = false
        }
    }
}
