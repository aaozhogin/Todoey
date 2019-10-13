//
//  Category+CoreDataProperties.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 11/10/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var newRelationship: NSSet?

}

// MARK: Generated accessors for newRelationship
extension Category {

    @objc(addNewRelationshipObject:)
    @NSManaged public func addToNewRelationship(_ value: Item)

    @objc(removeNewRelationshipObject:)
    @NSManaged public func removeFromNewRelationship(_ value: Item)

    @objc(addNewRelationship:)
    @NSManaged public func addToNewRelationship(_ values: NSSet)

    @objc(removeNewRelationship:)
    @NSManaged public func removeFromNewRelationship(_ values: NSSet)

}
