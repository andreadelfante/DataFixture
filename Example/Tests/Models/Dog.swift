//
//  Dog.swift
//  DataFixture_Tests
//
//  Created by Andrea Del Fante on 31/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RealmSwift
import DataFixture

class Dog: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    
    override class func primaryKey() -> String? {
        return "name"
    }
}

// MARK: - Fixture

extension Dog: FixtureFactoryable {
    static var factory: DogFixtureFactory {
        return DogFixtureFactory()
    }
}

struct DogFixtureFactory: JSONFixtureFactory {
    typealias Model = Dog
    
    func definition() -> FixtureDefinition<Dog> {
        define { (faker) in
            Dog(value: [
                "name": faker.name.name(),
                "age": faker.number.randomInt(min: 1, max: 15)
            ])
        }
    }
    
    func old() -> JSONFixtureDefinition<Dog> {
        redefine { (dog) in
            dog.age = 20
        }
    }
    
    func localeIT() -> FixtureDefinition<Dog> {
        redefine(locale: "it", { _ in })
    }
    
    func jsonDefinition() -> JSONFixtureDefinition<Dog> {
        defineJSON { (dog) in
            [
                "name": dog.name,
                "age": dog.age
            ]
        }
    }
}
