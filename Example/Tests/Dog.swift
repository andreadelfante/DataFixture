//
//  Dog.swift
//  DataFixture_Tests
//
//  Created by Andrea on 15/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import RealmSwift
import DataFixture

class Dog: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    
    override class func primaryKey() -> String? {
        return "name"
    }
}

class DogFixtureAttributes: FixtureAttributes {
    fileprivate static let nameKey = "name"
    fileprivate static let ageKey = "age"
    
    let name: String?
    let age: Int?
    
    init(name: String? = nil, age: Int? = nil) {
        self.name = name
        self.age = age
        
        super.init(attributes: [
            DogFixtureAttributes.nameKey: name as Any,
            DogFixtureAttributes.ageKey: age as Any
        ])
    }
}

struct DogFixture: JSONFixture {
    typealias Object = Dog
    
    func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> Dog {
        return Dog(value: [
            "name": attributes[DogFixtureAttributes.nameKey, faker.name.name()] as Any,
            "age": attributes[DogFixtureAttributes.ageKey, faker.number.randomInt(min: 1, max: 15)] as Any
        ])
    }
    
    func jsonFixture(object: Dog, resolver: FixtureResolver) -> [String : Any] {
        return [
            "name": object.name,
            "age": object.age
        ]
    }
}
