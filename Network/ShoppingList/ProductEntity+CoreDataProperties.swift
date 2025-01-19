//
//  ProductEntity+CoreDataProperties.swift
//  ShoppingList
//
//  Created by user252223 on 1/5/25.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var count: Int64
    @NSManaged public var categoryRelation: CategoryEntity?

}

extension ProductEntity : Identifiable {

}
