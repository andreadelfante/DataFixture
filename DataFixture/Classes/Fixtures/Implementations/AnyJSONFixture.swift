//
//  AnyJSONFixture.swift
//  DataFixture
//
//  Created by Andrea on 25/01/2020.
//

import Foundation

private class BoxJSONFixture<T: Fixture & JSONFixture>: BaseFixture<T.Object> {
    private let fixture: T!

    required init() {
        fixture = nil
    }

    init(fixture: T) {
        self.fixture = fixture
    }

    override func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> T.Object {
        return fixture.fixture(faker: faker, attributes: attributes, resolver: resolver)
    }

    override func jsonFixture(object: T.Object, resolver: FixtureResolver) -> [String: Any] {
        return fixture.jsonFixture(object: object, resolver: resolver)
    }
}

class AnyJSONFixture<T>: BaseFixture<T> {
    typealias Object = T

    private let box: BaseFixture<T>!

    required init() {
        box = nil
    }

    init<F: Fixture & JSONFixture>(_ fixture: F) where F.Object == T {
        box = BoxJSONFixture(fixture: fixture)
    }

    override func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> T {
        return box.fixture(faker: faker, attributes: attributes, resolver: resolver)
    }

    override func jsonFixture(object: T, resolver: FixtureResolver) -> [String: Any] {
        return box.jsonFixture(object: object, resolver: resolver)
    }
}
