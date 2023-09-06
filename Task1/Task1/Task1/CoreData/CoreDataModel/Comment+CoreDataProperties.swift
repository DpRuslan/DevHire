//
//  Comment+CoreDataProperties.swift
//  

import Foundation
import CoreData


extension Comment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Comment> {
        return NSFetchRequest<Comment>(entityName: "Comment")
    }

    @NSManaged public var body: String?
    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var postId: Int64
    @NSManaged public var post: Post?

}

extension Comment : Identifiable {

}
