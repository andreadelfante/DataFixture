//
//  Person.swift
//  DataFixture_Tests
//
//  Created by Andrea Del Fante on 31/10/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import RealmSwift
import DataFixture

class Person: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var birthday: Date?
    let dogs = List<Dog>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

// MARK: - Fixture

extension Person: FixtureFactoryable {
    static var factory: PersonFixtureFactory {
        return PersonFixtureFactory()
    }
}

struct PersonFixtureFactory: JSONFixtureFactory {
    typealias Model = Person
    
	static var id = 0
	
    func definition() -> FixtureDefinition<Person> {
        define { (faker) in
			PersonFixtureFactory.id += 1
			
            return Person(value: [
				"id": PersonFixtureFactory.id,
				"firstName": faker.name.firstName(),
                "lastName": faker.name.lastName(),
                "birthday": faker.date.forward(10),
                "dogs": Dog.factory.make(10)
            ])
        }
    }
    
    func with(firstName: String, lastName: String, birthday: Date? = nil) -> JSONFixtureDefinition<Person> {
        redefine { (person) in
            person.firstName = firstName
            person.lastName = lastName
            person.birthday = birthday
			
			return person
        }
    }
    
    func jsonDefinition() -> JSONFixtureDefinition<Person> {
        defineJSON { (person) in
            [
                "firstName": person.firstName,
                "lastName": person.lastName,
                "birthday": person.birthday?.timeIntervalSince1970 as Any,
                "dogs": Dog.factory.makeJSON(from: person.dogs)
            ]
        }
    }
}
