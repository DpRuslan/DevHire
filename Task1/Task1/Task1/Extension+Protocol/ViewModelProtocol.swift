//
//  ViewModelProtocol.swift
//

import Foundation
import CoreData
import UIKit.UITableViewCell

protocol ViewModelProtocol: AnyObject {
    associatedtype EntityType: NSManagedObject
    var sortDescriptors: [NSSortDescriptor]? { get }
    func makeFetchedResultsController(predicate: NSPredicate?) -> NSFetchedResultsController<EntityType>
    func numberOfItems() -> Int
    func fetchedResultsController() -> NSFetchedResultsController<EntityType>
    func itemAt(at index: Int) -> EntityType?
    func didSelectAt(at index: Int)
}

extension ViewModelProtocol {
    func makeFetchedResultsController(predicate: NSPredicate?) -> NSFetchedResultsController<EntityType> {
        let request = EntityType.fetchRequest() as! NSFetchRequest<EntityType>
        
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        let controller = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: AppDelegate.coreDataStack.managedContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        
        return controller
    }
    
    var sortDescriptors: [NSSortDescriptor]? {
        nil
    }
    
    func fetchedResultsController() -> NSFetchedResultsController<EntityType> {
        NSFetchedResultsController()
    }
    
    func numberOfItems() -> Int {
        fetchedResultsController().fetchedObjects?.count ?? 0
    }
    
    func itemAt(at index: Int) -> EntityType? {
        guard let item = fetchedResultsController().fetchedObjects?[index] else { return nil }
        return item
    }
    
    func didSelectAt(at index: Int) {}
}
