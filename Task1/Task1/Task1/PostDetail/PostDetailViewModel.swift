//
//  PostDetailViewModel.swift
//

import Foundation
import CoreData
import UIKit.UIImage

final class PostDetailViewModel: ViewModelProtocol {
    typealias EntityType = Comment
    let backImage = UIImage(named: "backImage")
    var postId: NSManagedObjectID?
    var post: Post
    weak var coordinator: PostDetailCoordinatorProtocol?
    
    init(postId: NSManagedObjectID) {
        self.postId = postId
        post = AppDelegate.coreDataStack.managedContext.object(with: postId) as! Post
    }
    
    func numberOfItems() -> Int {
        post.comments?.count ?? 0
    }
    
    func itemAt(at index: Int) -> Comment? {
        let comments = post.comments?.allObjects as? [Comment]
        let sortedComments = comments?.sortArrayByHeightOfIds()
//        let sortedComments = sortArrayByHeightOfIds(comments!)
        return sortedComments![index]
    }
    
    func showAmountOfComments() -> String {
        return ("Comments(\(Int(post.comments?.count ?? 0)))")
    }
    
    func exitVC() {
        coordinator?.exitVC()
    }
}
