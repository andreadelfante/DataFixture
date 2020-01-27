//
//  FixtureFactoryTests.swift
//  DataFixture_Tests
//
//  Created by Andrea on 15/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import DataFixture

class FixtureFactoryTests: XCTestCase {
    private var factory: TestFixtureFactory!

    override func setUp() {
        super.setUp()
        
        factory = TestFixtureFactory()
    }

    func testDefineWithClosure() {
        factory.define(for: Company.self, { (faker, attributes, resolver) -> Company in
            return Company(name: faker.company.name(),
                           employees: resolver.resolve(Person.self).create(10))
        })
        
        _ = factory.resolve(Company.self)
    }
    
    func testDefineWithClosureAndJSONClosure() {
        factory.define(for: Company.self, { (faker, attributes, resolver) -> Company in
            Company(name: faker.company.name(),
                    employees: resolver.resolve(Person.self).create(10))
        }) { (object, resolver) -> [String : Any] in
            return [
                "name": object.name,
                "employees": resolver.resolve(Person.self).createJSON(from: object.employees)
            ]
        }
        
        _ = factory.resolve(Company.self)
    }
    
    func testDefineWithFixture() {
        factory.define(for: Dog.self, fixture: DogFixture.self)
        
        _ = factory.resolve(Dog.self)
    }
}
