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
    case none, lactoseIntolerant, glutenSensitive, vegetarian, plantBased, kosher, keto, diabetic, dairyFree, lowCarb
    
    var description: String {
        switch self {
        case .none:
            return "None"
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
    case none, milk, eggs, fish, crustacean, treeNuts, peanuts, wheat, soybean
    
    var description: String {
        switch self {
        case .none:
            return "None"
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
        
        let ingredient = Ingredient(context: viewContext)
        recipe.ingredients = [
            ingredient.name = "3-4 pound whole chicken (ideally organic free-range; optional head and feet still on; at room temperature)",
            ingredient.name = "2 scallions",
            ingredient.name = "5 slices ginger",
            ingredient.name = "3 tablespoons scallions (finely minced, white and light green parts only)",
            ingredient.name = "2 tablespoons ginger (finely minced)",
            ingredient.name = "3 tablespoons oil",
            ingredient.name = "salt (to taste)",
            ingredient.name = "soy sauce (optional); replace with coconut aminos or tamari sauce if concerned about allergies or gluten intolerance"
        ]
        
        let instruction = Instruction(context: viewContext)
        recipe.instructions = [
            instruction.step = "1. Make sure your chicken is at room temperature (trying to poach a cold chicken right out of the refrigerator will result in uneven cooking or undercooking). Clean the chicken by rinsing it under cold water, paying special attention to the cavity. Any giblets should already be removed but there may still be organs on the inside that should be removed or sometimes stray feathers that need to be plucked. Experts recommend that it's not necessary to wash your chicken before cutting and cooking but in this case for a whole chicken (especially if you get it from a live poultry place or even from Asian markets), it's a step that shouldn't be skipped, in my opinion.  When washing and prepping the whole chicken, be very careful about splashing water and contaminating surfaces with unwanted bacteria. Be careful not to break or trim away any of the skin on the chicken, as you don’t want the meat exposed to the boiling water as it cooks. This will ensure a moist, silky texture in the final product.",
            instruction.step = "2. Fill a large stock pot with water, just enough to submerge the chicken completely. You can determine this by putting the entire chicken in the pot, filling it with water until the chicken is submerged, and then removing the chicken. Do not turn on the heat while the chicken is still in the pot! This method of ensuring you have just enough water to submerge the chicken (and avoiding any extra) will ensure you have a more flavorful stock to save at the end. We used about 18 cups of water to submerge a 4 pound chicken in a deep stock pot.",
            instruction.step = "3. Once you have your water properly measured into the pot, add 2 scallions and 5 slices of ginger, and bring it to a boil. Once boiling, slowly lower the chicken into the pot, legs down and head up. It’s ok if the breast is peeking out of the water a bit. The water will cool down and stop boiling when you add the chicken, so bring it up to a boil once again, and do not walk away from the pot.",
            instruction.step = "4. Once the water boils again, IMMEDIATELY lift the chicken out of the water very carefully. You can carefully hook two wooden spoons under the wings to lift the chicken up. The goal is to empty any colder water that may be trapped inside the cavity. Once you’ve released that water, lower the chicken back into the pot, and bring to a boil again.",
            instruction.step = "5. When the water is JUST starting to boil, turn the heat down. Keep it at barely a simmer. There should be very little movement in the water, but it also shouldn’t be still. Cover the pot, and keep the heat around the lowest setting so the liquid continues to simmer slowly. Cook for about 35-40 minutes, roughly 10-11 minutes per pound. Depending on the size of your chicken, it may take more or less time to cook it through. You can check to make sure the water is bubbling slowly/gently and not boiling too vigorously, but try to avoid uncovering the pot while it’s cooking.",
            instruction.step = "6. Poke a chopstick or skewer into the thigh to check for doneness. If the juices run clear, it's done. Carefully lift the chicken out of the pot and transfer it to a large bowl of ice water. Cool completely.",
            instruction.step = "7. While the chicken is cooling, make the sauce. You have the option to make two versions—one with just scallions, ginger, oil and salt, and one with soy sauce. The plain version is more traditional, as it really lets the flavors of chicken, ginger, and scallion shine through. Judy loves to add soy sauce, and it’s also a tasty option! Start with the plain version, and then scoop some of it out into another bowl and add soy sauce. Try both and see which your loved ones like best!",
            instruction.step = "8. When the chicken is out of the ice water, you can brush it lightly with oil or some of the fat floating atop the poaching liquid to give it that enticing, shiny look!",
            instruction.step = "9. To serve, carve your chicken into pieces that you can easily grab with chopsticks. For directions on the traditional Chinese way to cut up said chicken, follow this link: https://thewoksoflife.com/how-to-cut-whole-chicken-chinese/. Serve with your sauce(s) and some steamed rice."
        ]
        
        recipe.entryDate = .now
        recipe.meal = Meals.dinner.rawValue
        recipe.dietPreferences = DietPreferences.none.rawValue
        recipe.foodAllergies = FoodAllergies.none.rawValue
        recipe.cuisine = Cuisines.chinese.rawValue
        recipe.occasion = Occasions.chineseNewYear.rawValue
        recipe.servingSize = ServingSizes.family.rawValue
        
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
