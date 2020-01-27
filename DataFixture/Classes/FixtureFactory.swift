//
//  FixtureFactory.swift
//  DataFixture
//
//  Created by Andrea on 15/01/2020.
//

import Foundation

/// This class contains all the model fixture definitions.
/// Fixtures provide a convenient way to generate new model instances for testing / seeding your application's database.
open class FixtureFactory {
    private var fixtures: [String: [AnyHashable: Any]]

    /// Creates a new empty FixtureFactory.
    public init() {
        fixtures = [:]
    }

    /// Define a new fixture for the specified object type.
    /// - Parameters:
    ///   - objectType: The object type.
    ///   - name: The name of the fixture.
    ///   - fixtureClosure: The fixture closure to build a new object type.
    ///   - jsonClosureFixture: The json fixture closure to build a JSONObject of the object type.
    public func define<T>(
        for objectType: T.Type,
        name: AnyHashable = DataFixtureConfig.defaultName,
        _ fixtureClosure: @escaping (Faker, FixtureAttributes, FixtureResolver) -> T,
        _ jsonClosureFixture: @escaping (T, FixtureResolver) -> [String: Any] = { (_, _) in [:] }
    ) {
        let key = calculateKey(from: objectType.self)

        var associations = fixtures[key] ?? [:]
        associations[name] = FixtureWrapper(fixtureClosure: fixtureClosure, jsonFixtureClosure: jsonClosureFixture)
        fixtures[key] = associations
    }

    /// Define a new fixture for the specified object type.
    /// - Parameters:
    ///   - objectType: The object type.
    ///   - name: The name of the fixture.
    ///   - fixture: The fixture to build a new object type.
    public func define<T, F: Fixture>(
        for objectType: T.Type,
        name: AnyHashable = DataFixtureConfig.defaultName,
        fixture: F.Type
    ) where F.Object == T {
        let key = calculateKey(from: objectType.self)

        var associations = fixtures[key] ?? [:]
        associations[name] = AnyFixture(fixture.init())
        fixtures[key] = associations
    }

    /// Define a new fixture for the specified object type.
    /// - Parameters:
    ///   - objectType: The object type.
    ///   - name: The name of the fixture.
    ///   - fixture: The fixture to build a new object type and a new JSONObject of the object type..
    public func define<T, F: Fixture & JSONFixture>(
        for objectType: T.Type,
        name: AnyHashable = DataFixtureConfig.defaultName,
        fixture: F.Type
    ) where F.Object == T {
        let key = calculateKey(from: objectType.self)

        var associations = fixtures[key] ?? [:]
        associations[name] = AnyJSONFixture(fixture.init())
        fixtures[key] = associations
    }

    private func calculateKey<T>(from objectType: T.Type) -> String {
        return String(describing: objectType)
    }
}

extension FixtureFactory: FixtureResolver {
    public func resolve<T>(_ objectType: T.Type, name: AnyHashable) -> FixtureBuilder<T> {
        let key = calculateKey(from: objectType.self)

        guard let associations = fixtures[key] else {
            fatalError("Missing fixtures for type \"\(key)\"")
        }

        guard let fixture = associations[name] as? BaseFixture<T> else {
            fatalError("Missing fixture \"\(name)\" for type \"\(key)\"")
        }

        return FixtureBuilder(fixture: fixture, resolver: self)
    }
}
