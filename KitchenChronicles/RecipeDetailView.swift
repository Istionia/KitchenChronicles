//
//  RecipeDetailView.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 27/11/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject var dataController: DataController
    var recipe: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(recipe.name ?? "Unknown Recipe")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.bottom, 8)
                
                Text("Ingredients:")
                    .font(.title)
                    .fontWeight(.bold)
                
                List {
                    ForEach(recipe.ingredientsArray, id: \.id) { ingredient in
                        Text("\(ingredient.quantity) \(ingredient.name ?? "")")
                    }
                }
                .padding(.bottom, 16)
                
                Text("Instructions:")
                    .font(.headline)
                    .fontWeight(.bold)
                
                List {
                    ForEach(recipe.instructionsArray, id: \.id) { instruction in
                        Text("\(instruction.numberOf) \(instruction.step ?? "")")
                    }
                }
                .padding(.bottom, 16)
            }
            .padding()
        }
        .navigationTitle("Recipe Details")
    }
}

#Preview {
    let dataController = DataController(inMemory: true)
    dataController.createSampleData()
    
    let recipes = dataController.fetchRecipes()
    let sampleRecipe = recipes.first ?? Recipe(context: dataController.container.viewContext)
    
    return RecipeDetailView(dataController: dataController, recipe: sampleRecipe)
}
