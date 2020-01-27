//
//  FixtureWrapper.swift
//  DataFixture
//
//  Created by Andrea on 25/01/2020.
//

import Foundation

final class FixtureWrapper<T>: BaseFixture<T> {
    private let fixtureClosure: ((Faker, FixtureAttributes, FixtureResolver) -> T)!
    private let jsonFixtureClosure: ((T, FixtureResolver) -> [String: Any])!

    required init() {
        fixtureClosure = nil
        jsonFixtureClosure = nil
    }

    init(fixtureClosure: @escaping (Faker, FixtureAttributes, FixtureResolver) -> T,
         jsonFixtureClosure: @escaping (T, FixtureResolver) -> [String: Any]) {
        self.fixtureClosure = fixtureClosure
        self.jsonFixtureClosure = jsonFixtureClosure
    }

    override func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> T {
        return fixtureClosure(faker, attributes, resolver)
    }

    override func jsonFixture(object: T, resolver: FixtureResolver) -> [String: Any] {
        return jsonFixtureClosure(object, resolver)
    }
}
