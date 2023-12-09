//
//  ContentView.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 27/11/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("You have no recipes right now. Head over to the Recipe Editor to start bringing them in!")
                .font(.custom("Montserrat-Regular", size: 30))
        }
        .padding()
    }
}

#Preview {
    HomeView()
}
