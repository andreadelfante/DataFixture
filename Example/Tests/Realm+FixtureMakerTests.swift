//
//  Realm+FixtureMakerTests.swift
//  DataFixture_Tests
//
//  Created by Andrea Del Fante on 11/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
#if SWIFT_PACKAGE
import DataFixture_RealmSeeder
#else
import DataFixture
#endif

class RealmFixtureMakerTests: XCTestCase {
    private var realm: Realm!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        realm = try Realm(configuration: Realm.Configuration(inMemoryIdentifier: name))
    }

    func testCreateOneObjectInRealm() throws {
        let dog = try Dog.factory.create(in: realm)
        
        XCTAssertNotNil(dog.realm)
    }
    
    func testCreateManyObjectsInRealm() throws {
        try Dog.factory.create(50, in: realm).forEach({ (dog) in
            XCTAssertNotNil(dog.realm)
        })
    }
}
