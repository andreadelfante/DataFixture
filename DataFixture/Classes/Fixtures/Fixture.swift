//
//  Fixture.swift
//  DataFixture
//
//  Created by Andrea on 16/01/2020.
//

import Fakery

/// This typealias is used to prevent the need to `import Fakery`
/// - SeeAlso:
/// [Fakery](https://github.com/vadymmarkov/Fakery)
public typealias Faker = Fakery.Faker

/// This protocol defines the rules to create an object
public protocol Fixture {
    associatedtype Object

    /// Default constructor, used by FixtureFactory to build this fixture.
    init()

    /// This function creates a fixture object.
    /// - Parameters:
    ///   - faker: a faker object to create some random values.
    ///   - attributes: it contains attributes to override object fields.
    ///   - resolver: it resolves a specific fixture for nested fixture creations. Please use it to prevent circular references.
    /// - Returns: a new object.
    func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> Object
}
