//
//  RecipeListView.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 27/11/2023.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var dataController: DataController
    
    var body: some View {
        NavigationView {
            List {
                ForEach(dataController.fetchRecipes()) { recipe in
                    Text(recipe.name ?? "Unknown Recipe")
                }
            }
            .onAppear {
                _ = dataController.fetchRecipes()
            }
        }
        .navigationTitle("Recipes")
    }
}


#Preview {
    RecipeListView(dataController: .preview)
}
