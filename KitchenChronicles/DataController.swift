//
//  DataController.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 03/12/2023.
//

import CoreData

enum Meals {
    case breakfast, brunch, lunch, dinner, supper, appetizer, snack, dessert
}

enum DietPreferences {
    case lactoseIntolerant, glutenSensitive, vegetarian, plantBased, kosher, keto, diabetic, dairyFree, lowCarb
}

enum FoodAllergies {
    case milk, eggs, fish, crustacean, treeNuts, peanuts, wheat, soybean
}

enum Cuisines {
    case italian, mexican, chinese, indian, french, malaysian, singaporean, japanese, thai, greek, spanish, american, middleEastern, african, caribbean, latinAmerican, brazilian, korean, colombian
}

enum Occasions {
    case christmas, thanksgiving, diwali, chineseNewYear, eid, hanukkah, easter, oktoberfest
}

enum ServingSizes: Int {
    case small = 1
    case medium = 2
    case large = 4
    case family = 6
}

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")

        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }

        container.loadPersistentStores { storeDescription, error in
            if let error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        dataController.createSampleData()
        return dataController
    }()
    
    func createSampleData() {
        let viewContext = container.viewContext
        
        let recipe = Recipe(context: viewContext)
        recipe.id = UUID()
        recipe.name = "Kung Po King Prawns"
        recipe.ingredients
        recipe.instructions
        recipe.entryDate = .now
        recipe.meal
        recipe.dietPreferences
        recipe.foodAllergies
        recipe.cuisine
        recipe.occasion
        recipe.servingSize
        
        try? viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        objectWillChange.send()
        container.viewContext.delete(object)
        save()
    }
    
    private func delete(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs

        if let delete = try? container.viewContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
            let changes = [NSDeletedObjectsKey: delete.result as? [NSManagedObjectID] ?? []]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [container.viewContext])
        }
    }
    
    func deleteAll() {
        let request: NSFetchRequest<NSFetchRequestResult> = Recipe.fetchRequest()
        delete(request)
    }
}
