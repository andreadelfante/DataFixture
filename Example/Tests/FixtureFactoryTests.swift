//
//  FixtureFactoryTests.swift
//  DataFixture_Tests
//
//  Created by Andrea Del Fante on 06/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import Fakery
import DataFixture

class FixtureFactoryTests: XCTestCase {
    private let faker = Faker()
    private var expectedString1: String!
    private var expectedString2: String!
    private var expectedDate1: Date!
    
    override func setUp() {
        super.setUp()
        
        expectedString1 = faker.lorem.character()
        expectedString2 = faker.lorem.character()
        expectedDate1 = faker.date.birthday(1, 100)
    }
    
    func testMakeOneObject() {
        let dog = Dog.factory.make()
        
        XCTAssertNotNil(dog.name)
        XCTAssertFalse(dog.name.isEmpty)
        
        XCTAssertNotNil(dog.age)
        XCTAssertTrue(dog.age > 0)
    }
    
    func testMakeOneObjectWithRedefinition() {
        let dog = Dog.factory.old().make()
        
        XCTAssertNotNil(dog.name)
        XCTAssertFalse(dog.name.isEmpty)
        
        XCTAssertNotNil(dog.age)
        XCTAssertTrue(dog.age == 20)
    }
    
    func testMakeOneJSONObject() {
        let result = Person.factory.makeJSON()
        
        ["firstName", "lastName", "dogs", "birthday"].forEach { (key) in
            XCTAssertTrue(result[key] != nil)
        }
    }
    
    func testMakeOneJSONObjectWithRedefinition() {
        let result = Person.factory
            .with(firstName: expectedString1, lastName: expectedString2)
            .make()
        
        XCTAssertEqual(result.firstName, expectedString1)
        XCTAssertEqual(result.lastName, expectedString2)
        XCTAssertNil(result.birthday)
    }
    
    func testMakeOneObjectWithAssociatedJSONObjectWithRedefinition() {
        let result = Person.factory
            .with(firstName: expectedString1, lastName: expectedString2)
            .makeWithJSON()
        
        XCTAssertEqual(result.object.firstName, expectedString1)
        XCTAssertEqual(result.object.lastName, expectedString2)
        XCTAssertNil(result.object.birthday)
        
        XCTAssertEqual(result.JSON["firstName"] as? String, expectedString1)
        XCTAssertEqual(result.JSON["lastName"] as? String, expectedString2)
        XCTAssertNil(result.JSON["birthday"] as? TimeInterval)
    }
    
    func testMakeManyObjects() {
        let results = Person.factory.make(3)
        
        XCTAssertEqual(results.count, 3)
    }
    
    func testMakeManyObjectsWithRedefinition() {
        let results = Person.factory
            .with(firstName: expectedString1, lastName: expectedString2, birthday: expectedDate1)
            .make(3)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (person) in
            XCTAssertEqual(person.firstName, expectedString1)
            XCTAssertEqual(person.lastName, expectedString2)
            XCTAssertEqual(person.birthday, expectedDate1)
        }
    }
    
    func testMakeOneObjectWithAssociatedJSONObject() {
        let result = Dog.factory.makeWithJSON()
        
        XCTAssertEqual(result.JSON["name"] as? String, result.object.name)
        XCTAssertEqual(result.JSON["age"] as? Int, result.object.age)
    }
    
    func testMakeOneJSONArray() {
        let results = Person.factory.makeJSON(3)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (result) in
            ["firstName", "lastName", "dogs", "birthday"].forEach { (key) in
                XCTAssertTrue(result[key] != nil)
            }
        }
    }
    
    func testMakeOneJSONArrayWithRedefinition() {
        let results = Person.factory
            .with(firstName: expectedString1, lastName: expectedString2, birthday: expectedDate1)
            .makeJSON(3)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (person) in
            XCTAssertEqual(person["firstName"] as? String, expectedString1)
            XCTAssertEqual(person["lastName"] as? String, expectedString2)
            XCTAssertEqual(person["birthday"] as? TimeInterval, expectedDate1.timeIntervalSince1970)
        }
    }
    
    func testMakeManyObjectsWithAssociatedJSONArray() {
        let results = Dog.factory
            .old()
            .makeWithJSON(3)
                
        XCTAssertEqual(results.count, 3)
        results.forEach { (result) in
            XCTAssertEqual(result.JSON["name"] as? String, result.object.name)
            XCTAssertEqual(result.JSON["age"] as? Int, result.object.age)
        }
    }
    
    func testMakeManyObjectsWithAssociatedJSONArrayWithRedefinition() {
        let results = Person.factory
            .with(firstName: expectedString1, lastName: expectedString2, birthday: expectedDate1)
            .makeWithJSON(3)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (result) in
            XCTAssertEqual(result.object.firstName, expectedString1)
            XCTAssertEqual(result.object.lastName, expectedString2)
            XCTAssertEqual(result.object.birthday, expectedDate1)
            
            XCTAssertEqual(result.JSON["firstName"] as? String, expectedString1)
            XCTAssertEqual(result.JSON["lastName"] as? String, expectedString2)
            XCTAssertEqual(result.JSON["birthday"] as? TimeInterval, expectedDate1.timeIntervalSince1970)
        }
    }
    
    func testMakeObjectsFromJSON() throws {
        let companies = Company.factory.make(3)
        let results = Company.factory.makeJSON(from: companies)
        
        XCTAssertEqual(results.count, companies.count)
        try results.enumerated().forEach { (index, result) throws in
            let company = companies[index]
            
            XCTAssertEqual(result["name"] as? String, company.name)
            
            let employeesResult = try XCTUnwrap(result["employees"] as? [[String: Any]])
            employeesResult.enumerated().forEach { (index, result) in
                let employee = company.employees[index]
                
                XCTAssertEqual(result["firstName"] as? String, employee.firstName)
                XCTAssertEqual(result["lastName"] as? String, employee.lastName)
            }
        }
    }
    
    func testMakeObjectFromJSON() {
        let dog = Dog.factory.make()
        let result = Dog.factory.makeJSON(from: dog)
        
        XCTAssertEqual(result["name"] as? String, dog.name)
        XCTAssertEqual(result["age"] as? Int, dog.age)
    }
}
