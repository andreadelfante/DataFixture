//
//  RealmSeederTests.swift
//  DataFixture_Tests
//
//  Created by Andrea on 23/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import DataFixture
import RealmSwift

class RealmSeederTests: XCTestCase {
    private var realm: Realm!
    
    override func setUp() {
        super.setUp()
        
        realm = try! Realm(configuration: Realm.Configuration(inMemoryIdentifier: name))
    }

    func testSingleSeeding() {
        XCTAssertNoThrow(try realm.seed(TestSeeder.self))
        
        XCTAssertFalse(realm.isEmpty)
    }
    
    func testNestedSeeding() {
        XCTAssertNoThrow(try realm.seed(TestNestedSeeder.self))
        
        XCTAssertFalse(realm.isEmpty)
    }
    
    func testNestedMoreSeeding() {
        XCTAssertNoThrow(try realm.seed(TestNestedSeeder.self, TestSeeder.self))
        
        XCTAssertFalse(realm.isEmpty)
    }
}
