//
//  ArrayExtension.swift
//

import Foundation
import CoreData

extension Array where Element: NSManagedObject {
    func sortArrayByHeightOfIds() -> [Element] {
        self.sorted {
            ($0.value(forKey: "id") as? Int ?? 0) < ($1.value(forKey: "id") as? Int ?? 0)
        }
    }
}
