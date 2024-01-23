//
//  KitchenChroniclesApp.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 27/11/2023.
//

import SwiftUI

@main
struct KitchenChroniclesApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            RecipeListView(dataController: .preview)
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
