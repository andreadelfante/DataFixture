//
//  JSONFixture.swift
//  DataFixture
//
//  Created by Andrea on 16/01/2020.
//

import Foundation

/// This protocol defines the rules to create a JSON Object from an object.
public protocol JSONFixture: Fixture {

    /// This function transforms an object in a JSON Object.
    /// - Parameters:
    ///   - object: the object to transform, previously created by this fixture.
    ///   - resolver: it resolves a specific fixture for nested fixture creations. Please use it to prevent circular references.
    /// - Returns: The JSON Object
    func jsonFixture(object: Object, resolver: FixtureResolver) -> [String: Any]
}
