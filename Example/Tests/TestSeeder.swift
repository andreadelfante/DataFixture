//
//  TestSeeder.swift
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

struct TestSeeder: RealmSeeder {
    private let factory = TestFixtureFactory()
    
    func run(realm: Realm) throws {
        realm.add(factory.resolve(Person.self).create(5), update: .all)
        realm.add(factory.resolve(Dog.self).create(5), update: .all)
    }
}
