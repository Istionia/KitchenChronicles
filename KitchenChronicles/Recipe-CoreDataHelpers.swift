//
//  Recipe-CoreDataHelpers.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 04/12/2023.
//

import Foundation

extension Recipe {
    var recipeName: String {
        get { name ?? ""}
        set { name = newValue }
    }
}
