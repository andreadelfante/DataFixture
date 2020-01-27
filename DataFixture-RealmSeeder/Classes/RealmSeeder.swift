//
//  RealmSeeder.swift
//  DataFixture
//
//  Created by Andrea on 23/01/2020.
//

import RealmSwift

/// This typealias is used to prevent the need to `import RealmSwift`
public typealias Realm = RealmSwift.Realm

/// This protocol defines a seeder for Realm Database.
public protocol RealmSeeder {

    /// This init is used before running this seeder.
    init()

    /// Seed the Realm database.
    /// - Parameter realm: the Realm database to seed.
    func run(realm: Realm) throws
}
