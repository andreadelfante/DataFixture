//
//  FixtureResolver.swift
//  DataFixture
//
//  Created by Andrea on 25/01/2020.
//

import Foundation

/// This protocol defines a resolver to get a fixture.
public protocol FixtureResolver {

    /// Resolve a Fixture related to the object type
    /// - Parameters:
    ///   - objectType: The object type.
    ///   - name: The name of the fixture.
    /// - Returns: a fixture builder of the specified object type
    func resolve<T>(_ objectType: T.Type, name: AnyHashable) -> FixtureBuilder<T>
}

extension FixtureResolver {

    /// Resolve a Fixture related to the object type
    /// - Parameters:
    ///   - objectType: The object type.
    /// - Returns: a fixture builder of the specified object type
    public func resolve<T>(_ objectType: T.Type) -> FixtureBuilder<T> {
        return resolve(objectType, name: DataFixtureConfig.defaultName)
    }
    
    /// Resolve a Fixture related to the object type
    /// - Parameters:
    ///   - objectType: The object type.
    ///   - name: The name of the fixture.
    /// - Returns: a fixture builder of the specified object type
    public subscript<T>(_ objectType: T.Type, name: AnyHashable) -> FixtureBuilder<T> {
        return resolve(objectType, name: name)
    }
    
    /// Resolve a Fixture related to the object type
    /// - Parameters:
    ///   - objectType: The object type.
    /// - Returns: a fixture builder of the specified object type
    public subscript<T>(_ objectType: T.Type) -> FixtureBuilder<T> {
        return resolve(objectType)
    }
}
