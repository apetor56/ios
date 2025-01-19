//
//  Persistence.swift
//  ShoppingList
//
//  Created by user252223 on 1/5/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let context = controller.container.viewContext

        let category1 = CategoryEntity(context: context)
        category1.name = "Elektronika"

        let category2 = CategoryEntity(context: context)
        category2.name = "Ksiazki"

        let product1 = ProductEntity(context: context)
        product1.name = "Smartfon"
        product1.desc = "Nowoczesny smartfon z duzym ekranem"
        product1.price = 2999.99
        product1.count = 10
        product1.categoryRelation = category1

        let product2 = ProductEntity(context: context)
        product2.name = "Laptop"
        product2.desc = "Laptop do pracy"
        product2.price = 4999.99
        product2.count = 5
        product2.categoryRelation = category1

        let product3 = ProductEntity(context: context)
        product3.name = "Powiesc kryminalna"
        product3.desc = "Wciagajaca ksiazka"
        product3.price = 39.99
        product3.count = 50
        product3.categoryRelation = category2

        do {
            try context.save()
        } catch {
            fatalError("Unresolved error \(error.localizedDescription)")
        }

        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ShoppingList")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        if inMemory || shouldLoadFixtures() {
            addSampleData(context: container.viewContext)
        }
    }

    private func shouldLoadFixtures() -> Bool {
        let fetchRequest: NSFetchRequest<ProductEntity> = ProductEntity.fetchRequest()
        let count = (try? container.viewContext.count(for: fetchRequest)) ?? 0
        return count == 0
    }

    private func addSampleData(context: NSManagedObjectContext) {
        let category1 = CategoryEntity(context: context)
        category1.name = "Elektronika"

        let category2 = CategoryEntity(context: context)
        category2.name = "Książki"

        let product1 = ProductEntity(context: context)
        product1.name = "Smartfon"
        product1.desc = "Nowoczesny smartfon z dużym ekranem"
        product1.price = 2999.99
        product1.count = 10
        product1.categoryRelation = category1

        let product2 = ProductEntity(context: context)
        product2.name = "Laptop"
        product2.desc = "Laptop do pracy"
        product2.price = 4999.99
        product2.count = 5
        product2.categoryRelation = category1

        let product3 = ProductEntity(context: context)
        product3.name = "Powieść kryminalna"
        product3.desc = "Wciągająca książka"
        product3.price = 39.99
        product3.count = 50
        product3.categoryRelation = category2

        do {
            try context.save()
        } catch {
            print("Error saving sample data: \(error.localizedDescription)")
        }
    }
}
