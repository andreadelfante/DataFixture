//
//  Realm+Seeding.swift
//  DataFixture
//
//  Created by Andrea on 23/01/2020.
//

import RealmSwift

extension Realm {

    /// Launch the specified seeders to seed this Realm Database.
    /// Use this function to launch nested seeders calls: it is transaction-safe.
    /// - Parameter seederTypes: the specified seeders to run.
    public func seed(_ seederTypes: RealmSeeder.Type...) throws {
        try safeWrite {
            try seederTypes.forEach { (type) in
                try type.init().run(realm: self)
            }
        }
    }
    
    internal func safeWrite(_ transaction: () throws -> Void) throws {
        guard !self.isInWriteTransaction else {
            try transaction()
            return
        }

        try write {
            try transaction()
        }
    }
}
