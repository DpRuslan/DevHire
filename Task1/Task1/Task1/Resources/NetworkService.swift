//
//  NetworkService.swift
// 

import Foundation
import UIKit

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
        APIManager.shared.request(endpoint: URLExtension.usersEndpoint.rawValue, method: .GET) { [weak self] result in
            defer {
                dispatchGroup.leave()
            }
            
            self?.parseResponse(res: result, myData: &users, decodeStruct: UserResponse.self, err: &customError, errorFlag: &hasError)
        }
        
        if !hasError {
            dispatchGroup.enter()
            APIManager.shared.request(endpoint: URLExtension.postsEndpoint.rawValue, method: .GET) { [weak self] result in
                defer {
                    dispatchGroup.leave()
                }
                
                self?.parseResponse(res: result, myData: &posts, decodeStruct: PostResponse.self, err: &customError, errorFlag: &hasError)
            }
        }
        
        if !hasError {
            dispatchGroup.enter()
            APIManager.shared.request(endpoint: URLExtension.commentsEndpoint.rawValue, method: .GET) { [weak self] result in
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
