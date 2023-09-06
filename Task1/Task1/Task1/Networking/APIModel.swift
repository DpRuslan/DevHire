//
//  APIModel.swift
//

import Foundation

// MARK: UserResponse

struct UserResponse: Decodable {
    var id: Int?
    var name: String?
    var username: String?
}

// MARK: PostResponse

struct PostResponse: Decodable {
    var userId: Int?
    var id: Int?
    var title: String?
    var body: String?
}

// MARK: CommentResponse

struct CommentResponse: Decodable {
    var postId: Int?
    var id: Int?
    var email: String?
    var body: String?
}

