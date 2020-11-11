//
//  RealmSeederTests.swift
//  DataFixture_Tests
//
//  Created by Andrea Del Fante on 02/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
#if SWIFT_PACKAGE
import DataFixture_RealmSeeder
#else
import DataFixture
#endif

class RealmSeederTests: XCTestCase {
    private var realm: Realm!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        realm = try Realm(configuration: Realm.Configuration(inMemoryIdentifier: name))
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
