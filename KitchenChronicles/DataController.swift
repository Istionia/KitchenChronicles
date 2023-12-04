//
//  DataController.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 03/12/2023.
//

import CoreData

enum Meals: String, CaseIterable {
    case breakfast, brunch, lunch, dinner, supper, appetizer, snack, dessert
    
    var description: String {
        switch self {
        case .breakfast:
            return "Breakfast"
        case .brunch:
            return "Brunch"
        case .lunch:
            return "Lunch"
        case .dinner:
            return "Dinner"
        case .supper:
            return "Supper"
        case .appetizer:
            return "Appetizers"
        case .snack:
            return "Snacks"
        case .dessert:
            return "Desserts"
        }
    }
}

enum DietPreferences: String, CaseIterable {
    case lactoseIntolerant, glutenSensitive, vegetarian, plantBased, kosher, keto, diabetic, dairyFree, lowCarb
    
    var description: String {
        switch self {
        case .lactoseIntolerant:
            return "Lactose Intolerant"
        case .glutenSensitive:
            return "Gluten Sensitive/Intolerant"
        case .vegetarian:
            return "Vegetarian"
        case .plantBased:
            return "Plant-Based"
        case .kosher:
            return "Kosher"
        case .keto:
            return "Keto"
        case .diabetic:
            return "Diabetic"
        case .dairyFree:
            return "Dairy Free"
        case .lowCarb:
            return "Low Carb"
        }
    }
}

enum FoodAllergies: String, CaseIterable {
    case milk, eggs, fish, crustacean, treeNuts, peanuts, wheat, soybean
    
    var description: String {
        switch self {
        case .milk:
            return "Milk"
        case .eggs:
            return "Eggs"
        case .fish:
            return "Fish"
        case .crustacean:
            return "Crustacean Shellfish"
        case .treeNuts:
            return "Tree Nuts"
        case .peanuts:
            return "Peanuts"
        case .wheat:
            return "Wheat"
        case .soybean:
            return "Soybeans"
        }
    }
}

enum Cuisines: String, CaseIterable {
    case italian, mexican, chinese, indian, french, malaysian, singaporean, filipino, japanese, thai, greek, spanish, american, middleEastern, african, caribbean, latinAmerican, brazilian, korean, colombian
    
    var description: String {
        switch self {
        case .italian:
            return "Italian Cuisine"
        case .mexican:
            return "Mexican Cuisine"
        case .chinese:
            return "Chinese Cuisine"
        case .indian:
            return "Indian Cuisine"
        case .french:
            return "French Cuisine"
        case .malaysian:
            return "Malaysian Cuisine"
        case .singaporean:
            return "Singaporean Cuisine"
        case .filipino:
            return "Filipino Cuisine"
        case .japanese:
            return "Japanese Cuisine"
        case .thai:
            return "Thai Cuisine"
        case .greek:
            return "Greek Cuisine"
        case .spanish:
            return "Spanish Cuisine"
        case .american:
            return "American Cuisine"
        case .middleEastern:
            return "Middle Eastern Cuisine"
        case .african:
            return "African Cuisine"
        case .caribbean:
            return "Caribbean Cuisine"
        case .latinAmerican:
            return "Latin American Cuisine"
        case .brazilian:
            return "Brazilian Cuisine"
        case .korean:
            return "Korean Cuisine"
        case .colombian:
            return "Colombian Cuisine"
        }
    }
}

enum Occasions: String, CaseIterable {
    case christmas, thanksgiving, diwali, chineseNewYear, eid, hanukkah, diaDeLosMuertos, oktoberfest
    
    var description: String {
        switch self {
        case .christmas:
            return "Christmas"
        case .thanksgiving:
            return "Thanksgiving"
        case .diwali:
            return "Diwali"
        case .chineseNewYear:
            return "Chinese New Year"
        case .eid:
            return "Eid"
        case .hanukkah:
            return "Hanukkah"
        case .diaDeLosMuertos:
            return "Dia de Los Muertos"
        case .oktoberfest:
            return "Oktoberfest"
        }
    }
}

enum ServingSizes: String, CaseIterable {
    case small, medium, large, family
    
    var description: String {
        switch self {
        case .small:
            return "Small (1-2 servings)"
        case .medium:
            return "Medium (2-4 servings)"
        case .large:
            return "Large (4-6 servings)"
        case .family:
            return "Family Size (6+ servings)"
        }
    }
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
        recipe.name = "Cantonese Poached Chicken (Bai Qie Ji)"
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
