//
//  StorageService.swift
//  

import Foundation
import CoreData

// MARK: Check if CoreData is empty
extension AppDelegate {
    func checkForEmptyCoreData() -> Bool {
        let managedContext = AppDelegate.coreDataStack.managedContext
        do {
            if try managedContext.count(for: NSFetchRequest<User>(entityName: "User")) == 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("error - \(error.localizedDescription)")
        }
        
        return false
    }
}

// MARK: If CoreData is empty than save data to it
extension AppDelegate {
    func saveToCoreData(users: [UserResponse], posts: [PostResponse], comments: [CommentResponse]) {
        let managedContext = AppDelegate.coreDataStack.managedContext
        for user in users {
            let newUser = User(context: managedContext)
            newUser.id = Int64(user.id ?? -1)
            newUser.name = user.name ?? "None"
            newUser.username = user.username ?? "None"
            
            for post in posts {
                guard post.userId == user.id else { continue }
                
                let newPost = Post(context: managedContext)
                newPost.id = Int64(post.id ?? -1)
                newPost.userId = Int64(post.userId ?? -1)
                newPost.body = post.body ?? "None"
                newPost.title = post.title ?? "None"
                
                newUser.addToPosts(newPost)
                
                for comment in comments {
                    guard comment.postId == post.id else { continue }
                    
                    let newComment = Comment(context: managedContext)
                    newComment.id = Int64(comment.id ?? -1)
                    newComment.postId = Int64(comment.postId ?? -1)
                    newComment.body = comment.body ?? "None"
                    newComment.email = comment.email ?? "None"
                    
                    newPost.addToComments(newComment)
                }
            }
        }
        
        AppDelegate.coreDataStack.saveContext()
    }
}
