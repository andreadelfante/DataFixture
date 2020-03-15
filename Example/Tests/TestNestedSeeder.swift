//
//  TestNestedSeeder.swift
//  DataFixture_Tests
//
//  Created by Andrea on 23/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

#if SWIFT_PACKAGE
import DataFixture_RealmSeeder
#else
import DataFixture
#endif

struct TestNestedSeeder: RealmSeeder {
    private let factory = TestFixtureFactory()
    
    func run(realm: Realm) throws {
        realm.add(factory.resolve(Person.self).create(), update: .all)
        
        try realm.seed(TestSeeder.self)
    }
}
