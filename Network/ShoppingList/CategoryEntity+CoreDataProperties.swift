//
//  CategoryEntity+CoreDataProperties.swift
//  ShoppingList
//
//  Created by user252223 on 1/5/25.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var productRelation: NSSet?

}

// MARK: Generated accessors for productRelation
extension CategoryEntity {

    @objc(addProductRelationObject:)
    @NSManaged public func addToProductRelation(_ value: ProductEntity)

    @objc(removeProductRelationObject:)
    @NSManaged public func removeFromProductRelation(_ value: ProductEntity)

    @objc(addProductRelation:)
    @NSManaged public func addToProductRelation(_ values: NSSet)

    @objc(removeProductRelation:)
    @NSManaged public func removeFromProductRelation(_ values: NSSet)

}

extension CategoryEntity : Identifiable {

}
