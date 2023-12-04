//
//  KitchenChroniclesTests.swift
//  KitchenChroniclesTests
//
//  Created by Tim Yoong on 27/11/2023.
//

import CoreData
import XCTest
@testable import KitchenChronicles

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
