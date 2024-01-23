//
//  Recipe-CoreDataHelpers.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 04/12/2023.
//

import Foundation

extension Recipe {
    var ingredientsArray: [Ingredient] {
        ingredients?.allObjects as? [Ingredient] ?? []
    }
    
    var instructionsArray: [Instruction] {
        instructions?.allObjects as? [Instruction] ?? []
    }
    
    var recipeName: String {
        get { name ?? "" }
        set { name = newValue }
    }
    
    var recipeCuisine: String {
        get { cuisine ?? "" }
        set { cuisine = newValue }
    }
    
    var recipeDietPreferences: String {
        get { dietPreferences ?? "" }
        set { dietPreferences = newValue }
    }
    
    var recipeFoodAllergies: String {
        get { foodAllergies ?? ""}
        set { foodAllergies = newValue }
    }
    
    var recipeMeal: String {
        get { meal ?? "" }
    }
    
    var recipeOccasion: String {
        get { occasion ?? "" }
    }
    
    var recipeServingSize: String {
        get { servingSize ?? "" }
    }
    
    var recipePrepTime: Int16 {
        prepTime
    }
    
    var recipeEntryDate: Date {
        entryDate ?? .now
    }
    
    var recipeModificationDate: Date {
        modificationDate ?? .now
    }
}
