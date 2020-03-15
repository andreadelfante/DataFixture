//
//  Person.swift
//  DataFixture_Tests
//
//  Created by Andrea on 15/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RealmSwift
import DataFixture

class Person: Object {
    @objc dynamic var key: Int = 0
    @objc dynamic var firstName: String = "" { didSet { generateKey() } }
    @objc dynamic var lastName: String = "" { didSet { generateKey() } }
    @objc dynamic var birthday: Date?
    let dogs = List<Dog>()
    
    override class func primaryKey() -> String? {
        return "key"
    }
    
    private func generateKey() {
        var hasher = Hasher()
        hasher.combine(firstName)
        hasher.combine(lastName)
        key = hasher.finalize()
    }
}

struct PersonFixture: JSONFixture {
    typealias Object = Person
    
    func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> Person {
        return Person(value: [
            "firstName": attributes["firstName", faker.name.firstName()] as Any,
            "lastName": attributes["lastName", faker.name.lastName()] as Any,
            "birthday": attributes["birthday", faker.date.forward(10)] as Any,
            "dogs": resolver.resolve(Dog.self).create(10)
        ])
    }
    
    func jsonFixture(object: Person, resolver: FixtureResolver) -> [String : Any] {
        return [
            "firstName": object.firstName,
            "lastName": object.lastName,
            "birthday": object.birthday?.timeIntervalSince1970 as Any,
            "dogs": resolver.resolve(Dog.self).createJSON(from: object.dogs)
        ]
    }
}
