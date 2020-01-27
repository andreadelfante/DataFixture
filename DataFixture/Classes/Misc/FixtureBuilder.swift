//
//  FixtureBuilder.swift
//  DataFixture
//
//  Created by Andrea on 15/01/2020.
//

import Foundation

/// This struct provides functions to create fixtures.
public struct FixtureBuilder<T> {
    private let fixture: BaseFixture<T>
    private let resolver: FixtureResolver
    private let faker: Faker

    internal init(fixture: BaseFixture<T>, resolver: FixtureResolver) {
        self.fixture = fixture
        self.resolver = resolver
        self.faker = Faker(locale: DataFixtureConfig.locale)
    }
}

extension FixtureBuilder {
    
    /// Create a single object from fixture
    /// - Parameter attributes: a dictionary to override fields during generating the object
    /// - Returns: the object
    public func create(_ attributes: FixtureAttributes = FixtureAttributes()) -> T {
        return create(1, attributes).first!
    }

    /// Create a collection of object from fixture
    /// - Parameter number: the count of the objects to generate.
    /// - Parameter attributes: a dictionary to override fields during generating the objects
    /// - Returns: a collection of objects
    public func create(_ number: Int, _ attributes: FixtureAttributes = FixtureAttributes()) -> [T] {
        return (0..<number)
            .map { _ in fixture.fixture(faker: faker, attributes: attributes, resolver: resolver) }
    }
    
    /// Create a JSON Object from fixture. Please be sure to define `jsonFixtureClosure` or to implement `JSONFixture`, otherwise this function produces an empty JSON Object.
    /// - Parameter attributes: a dictionary to override fields during generating the json object
    /// - Returns: a JSON Object
    public func createJSON(_ attributes: FixtureAttributes = FixtureAttributes()) -> [String: Any] {
        return createJSON(1, attributes).first!
    }

    /// Create a JSON Array from fixture. Please be sure to define `jsonFixtureClosure` or to implement `JSONFixture`, otherwise this function produces an empty JSON Objects.
    /// - Parameter number: the count of the JSON Objects to generate.
    /// - Parameter attributes: a dictionary to override fields during generating the json objects
    /// - Returns: a JSON Array
    public func createJSON(_ number: Int, _ attributes: FixtureAttributes = FixtureAttributes()) -> [[String: Any]] {
        return (0..<number)
            .map { _ in
                let object = fixture.fixture(faker: faker, attributes: attributes, resolver: resolver)
                return fixture.jsonFixture(object: object, resolver: resolver)
            }
    }

    /// Create a JSON Object from fixture. Please be sure to define `jsonFixtureClosure` or to implement `JSONFixture`, otherwise this function produces an empty JSON Object.
    /// - Parameter object: the object to transform in JSON Object.
    /// - Returns: a JSON Object
    public func createJSON(from object: T) -> [String: Any] {
        return createJSON(from: [object]).first!
    }

    /// Create a JSON Array from fixture. Please be sure to define `jsonFixtureClosure` or to implement `JSONFixture`, otherwise this function produces an empty JSON Objects.
    /// - Parameter objects: a sequence of objects to transform in JSONArray.
    /// - Returns: a JSON Array
    public func createJSON<S: Sequence>(from objects: S) -> [[String: Any]] where S.Element == T {
        return objects.map { fixture.jsonFixture(object: $0, resolver: resolver) }
    }
    
    /// Create a tuple of object and its JSONObject. Please be sure to define `jsonFixtureClosure` or to implement `JSONFixture`, otherwise this function produces an empty JSON Object.
    /// - Parameter attributes: a dictionary to override fields during generating the objects and its JSON object.
    /// - Returns: a tuple of object and its JSONObject.
    public func createWithJSON(_ attributes: FixtureAttributes = FixtureAttributes()) -> (object: T, JSON: [String: Any]) {
        return createWithJSON(1, attributes).first!
    }

    /// Create an array of tuples of object and its JSONObject. Please be sure to define `jsonFixtureClosure` or to implement `JSONFixture`, otherwise this function produces an empty JSON Object.
    /// - Parameter number: the count of the tuples to generate.
    /// - Parameter attributes: a dictionary to override fields during generating the objects and its JSON object.
    /// - Returns: a tuple of object and its JSONObject.
    public func createWithJSON(_ number: Int, _ attributes: FixtureAttributes = FixtureAttributes()) -> [(object: T, JSON: [String: Any])] {
        return (0..<number)
            .map { _ in
                let object = fixture.fixture(faker: faker, attributes: attributes, resolver: resolver)
                let JSON = fixture.jsonFixture(object: object, resolver: resolver)

                return (object, JSON)
            }
    }
}
