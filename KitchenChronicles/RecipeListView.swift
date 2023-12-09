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
                ForEach(recipes) { recipe in
                    Text(recipe.name)
                }
            }
        }
        .navigationTitle("Recipes")
    }
}


#Preview {
    RecipeListView(dataController: .preview)
}
