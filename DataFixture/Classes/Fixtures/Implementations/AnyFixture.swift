//
//  AnyFixture.swift
//  DataFixture
//
//  Created by Andrea on 25/01/2020.
//

import Foundation

private class BoxFixture<T: Fixture>: BaseFixture<T.Object> {
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
}

class AnyFixture<T>: BaseFixture<T> {
    typealias Object = T

    private let box: BaseFixture<T>!

    required init() {
        box = nil
    }

    init<F: Fixture>(_ fixture: F) where F.Object == T {
        box = BoxFixture(fixture: fixture)
    }

    override func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> T {
        return box.fixture(faker: faker, attributes: attributes, resolver: resolver)
    }
}
