//
//  BaseFixture.swift
//  DataFixture
//
//  Created by Andrea on 25/01/2020.
//

import Foundation

class BaseFixture<T>: Fixture, JSONFixture {
    typealias Object = T

    required init() {}

    func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> T {
        fatalError("PLEASE IMPLEMENT THIS")
    }

    func jsonFixture(object: T, resolver: FixtureResolver) -> [String: Any] {
        fatalError("PLEASE IMPLEMENT THIS")
    }
}
