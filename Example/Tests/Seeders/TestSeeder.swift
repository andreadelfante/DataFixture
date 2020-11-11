//
//  TestSeeder.swift
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

struct TestSeeder: RealmSeeder {
    func run(realm: Realm) throws {
        try Person.factory.create(5, in: realm)
        try Dog.factory.create(5, in: realm)
        
        try Dog.factory.create(in: realm)
    }
}
