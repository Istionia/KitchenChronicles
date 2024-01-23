//
//  DevelopmentTests.swift
//  KitchenChroniclesTests
//
//  Created by Tim Yoong on 10/12/2023.
//

import CoreData
import XCTest
@testable import KitchenChronicles

class DevelopmentTestCase: BaseTestCase {
    func testCreateSampleData() {
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            let recipes = try dataController.container.viewContext.fetch(fetchRequest)
            XCTAssertFalse(recipes.isEmpty, "Sample data creation failed")
        } catch {
            XCTFail("Error fetching recipes: \(error.localizedDescription)")
        }
    }
        
    func testSave() {
        let viewContext = dataController.container.viewContext
        let recipe = Recipe(context: viewContext)
        recipe.name = "Test Recipe"
        dataController.save()
            
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            let recipes = try viewContext.fetch(fetchRequest)
            XCTAssertTrue(recipes.contains(recipe), "Save function failed to save the object")
        } catch {
            XCTFail("Error fetching recipes: \(error.localizedDescription)")
        }
    }
        
    func testDelete() {
        let viewContext = dataController.container.viewContext
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            let recipes = try viewContext.fetch(fetchRequest)
            guard let firstRecipe = recipes.first else {
                XCTFail("No recipe found for testing delete")
                return
            }
            dataController.delete(firstRecipe)
                
            XCTAssertFalse(recipes.contains(firstRecipe), "Delete function failed to remove the object")
        } catch {
            XCTFail("Error fetching recipes: \(error.localizedDescription)")
        }
    }
        
    func testDeleteAll() {
        dataController.deleteAll()
        let fetchRequest: NSFetchRequest<Recipe> = Recipe.fetchRequest()
        do {
            let recipes = try dataController.container.viewContext.fetch(fetchRequest)
            XCTAssertTrue(recipes.isEmpty, "DeleteAll function failed to remove all objects")
        } catch {
            XCTFail("Error fetching recipes: \(error.localizedDescription)")
        }
    }
}
