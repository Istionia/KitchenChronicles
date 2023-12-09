//
//  Instruction-CoreDataHelpers.swift
//  KitchenChronicles
//
//  Created by Tim Yoong on 04/12/2023.
//

import Foundation

extension Instruction {
    var instructionStep: String {
        get { step ?? "" }
    }
    
    var instructionNumber: Int16 {
        numberOf
    }
}
