//
//  TestNestedSeeder.swift
//  DataFixture_Tests
//
//  Created by Andrea Del Fante on 02/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
#if SWIFT_PACKAGE
import DataFixture_RealmSeeder
#else
import DataFixture
#endif

struct TestNestedSeeder: RealmSeeder {
    func run(realm: Realm) throws {
        realm.add(Person.factory.make(), update: .all)
        
        try realm.seed(TestSeeder.self)
    }
}
