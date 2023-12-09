//
//  Ingredient-CoreDataHelpers.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 04/12/2023.
//

import Foundation

extension Ingredient {
    var ingredientName: String {
        get { name ?? "" }
    }
    
    var ingredientAmount: Int16 {
        numberOf
    }
}
