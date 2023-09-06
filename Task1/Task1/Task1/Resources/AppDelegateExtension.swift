//
//  AppDelegateExtension.swift
//  

import Foundation
import CoreData
import UIKit

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

// MARK: Make all 3 requests for different endpoints
extension AppDelegate {
    func doRequests() {
        var users: [UserResponse] = []
        var posts: [PostResponse] = []
        var comments: [CommentResponse] = []
        var hasError = false
        var customError: CustomError? = nil
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        APIManager.shared.request(endpoint: .usersEndpoint, method: .GET) { [weak self] result in
            defer {
                dispatchGroup.leave()
            }
            
            self?.parseResponse(res: result, myData: &users, decodeStruct: UserResponse.self, err: &customError, errorFlag: &hasError)
        }
        
        if !hasError {
            dispatchGroup.enter()
            APIManager.shared.request(endpoint: .postsEndpoint, method: .GET) { [weak self] result in
                defer {
                    dispatchGroup.leave()
                }
                
                self?.parseResponse(res: result, myData: &posts, decodeStruct: PostResponse.self, err: &customError, errorFlag: &hasError)
            }
        }
        
        if !hasError {
            dispatchGroup.enter()
            APIManager.shared.request(endpoint: .commentsEndpoint, method: .GET) { [weak self] result in
                defer {
                    dispatchGroup.leave()
                }
                
                self?.parseResponse(res: result, myData: &comments, decodeStruct: CommentResponse.self, err: &customError, errorFlag: &hasError)
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            if hasError {
                self.errorAlert(message: customError!.localizedDescription)
            } else {
                self.saveToCoreData(users: users, posts: posts, comments: comments)
                self.dataIsReady()
            }
        }
    }
}

// MARK: Parse the response
extension AppDelegate {
    private func parseResponse<T: Decodable, Y>(res: Result<Data, CustomError>, myData: inout Y, decodeStruct: T.Type, err: inout CustomError?, errorFlag: inout Bool) {
        switch res {
        case .success(let data):
            do {
                myData = try JSONDecoder().decode([T].self, from: data) as! Y
            } catch {
                print("Error decoding - \(error)")
            }
        case .failure(let error):
            err = error
            errorFlag = true
        }
    }
}

// MARK: Show spinner while data is loading
extension AppDelegate {
    func showLoading() {
        let loadingController = LoadingController()
        window?.rootViewController = loadingController
        window?.makeKeyAndVisible()
    }
}

// MARK: Show error alert if it occurs
extension AppDelegate {
    private func errorAlert(message: String) {
        DispatchQueue.main.async {
            if let rootViewController = self.window?.rootViewController {
                let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
                    alertController.dismiss(animated: true) {
                        self.dataIsReady()
                    }
                })
                
                rootViewController.present(alertController, animated: true, completion: nil)
            }
        }
    }
}

// MARK: If CoreData is empty than save data to it
extension AppDelegate {
    private func saveToCoreData(users: [UserResponse], posts: [PostResponse], comments: [CommentResponse]) {
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

// MARK: Trigger that data is ready for user
extension AppDelegate {
    func dataIsReady() {
        navVC = UINavigationController()
        window?.rootViewController = navVC
        coordinator = MainCoordinator()
        coordinator!.navigationController = navVC
        window?.makeKeyAndVisible()
       
        coordinator!.start()
    }
}
