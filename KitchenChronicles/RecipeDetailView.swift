//
//  RecipeDetailView.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 27/11/2023.
//

import SwiftUI

struct RecipeDetailView: View {
    @StateObject var dataController: DataController
    
    var body: some View {
        Text("Recipe Details")
    }
}

#Preview {
    RecipeDetailView(dataController: .preview)
}
