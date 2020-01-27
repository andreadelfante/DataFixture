//
//  FixtureBuilderTests.swift
//  DataFixture_Tests
//
//  Created by Andrea on 20/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import DataFixture

class FixtureBuilderTests: XCTestCase {
    private var faker: Faker!
    private var factory: TestFixtureFactory!
    private var fixedAttributes: DogFixtureAttributes!
    
    override func setUp() {
        super.setUp()
        
        faker = Faker()
        factory = TestFixtureFactory()
        fixedAttributes = DogFixtureAttributes(name: "fixed name", age: 1)
    }
    
    func testCreateOneObject() {
        _ = factory.resolve(Person.self).create()
    }
    
    func testCreateOneObjectWithAttributes() {
        let result = factory.resolve(Dog.self).create(fixedAttributes)
        
        XCTAssertEqual(result.name, fixedAttributes.name)
        XCTAssertEqual(result.age, fixedAttributes.age)
    }
    
    func testCreateOneJSONObject() {
        let result = factory.resolve(Person.self).createJSON()
        
        ["firstName", "lastName", "dogs", "birthday"].forEach { (key) in
            XCTAssertTrue(result[key] != nil)
        }
    }
    
    func testCreateOneJSONObjectWithAttributes() {
        let result = factory.resolve(Dog.self).createJSON(fixedAttributes)
        
        XCTAssertEqual(result["name"] as? String, fixedAttributes.name)
        XCTAssertEqual(result["age"] as? Int, fixedAttributes.age)
    }
    
    func testCreateOneObjectWithAssociatedJSONObjectWithAttributes() {
        let result = factory.resolve(Dog.self).createWithJSON(fixedAttributes)
        
        XCTAssertEqual(result.object.name, fixedAttributes.name)
        XCTAssertEqual(result.object.age, fixedAttributes.age)
        
        XCTAssertEqual(result.JSON["name"] as? String, fixedAttributes.name)
        XCTAssertEqual(result.JSON["age"] as? Int, fixedAttributes.age)
    }
    
    func testCreateManyObjects() {
        let results = factory.resolve(Person.self).create(3)
        
        XCTAssertEqual(results.count, 3)
    }
    
    func testCreateManyObjectsWithAttributes() {
        let results = factory.resolve(Dog.self).create(3, fixedAttributes)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (dog) in
            XCTAssertEqual(dog.name, fixedAttributes.name)
            XCTAssertEqual(dog.age, fixedAttributes.age)
        }
    }
    
    func testCreateOneObjectWithAssociatedJSONObject() {
        let result = factory.resolve(Dog.self).createWithJSON()
        
        XCTAssertEqual(result.JSON["name"] as? String, result.object.name)
        XCTAssertEqual(result.JSON["age"] as? Int, result.object.age)
    }
    
    func testCreateOneJSONArray() {
        let results = factory.resolve(Person.self).createJSON(3)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (result) in
            ["firstName", "lastName", "dogs", "birthday"].forEach { (key) in
                XCTAssertTrue(result[key] != nil)
            }
        }
    }
    
    func testCreateOneJSONArrayWithAttributes() {
        let results = factory.resolve(Dog.self).createJSON(3, fixedAttributes)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (result) in
            XCTAssertEqual(result["name"] as? String, fixedAttributes.name)
            XCTAssertEqual(result["age"] as? Int, fixedAttributes.age)
        }
    }
    
    func testCreateManyObjectsWithAssociatedJSONArray() {
        let results = factory.resolve(Dog.self).createWithJSON(3)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (result) in
            XCTAssertEqual(result.JSON["name"] as? String, result.object.name)
            XCTAssertEqual(result.JSON["age"] as? Int, result.object.age)
        }
    }
    
    func testCreateManyObjectsWithAssociatedJSONArrayWithAttributes() {
        let results = factory.resolve(Dog.self).createWithJSON(3, fixedAttributes)
        
        XCTAssertEqual(results.count, 3)
        results.forEach { (result) in
            XCTAssertEqual(result.object.name, fixedAttributes.name)
            XCTAssertEqual(result.object.age, fixedAttributes.age)
            
            XCTAssertEqual(result.JSON["name"] as? String, fixedAttributes.name)
            XCTAssertEqual(result.JSON["age"] as? Int, fixedAttributes.age)
        }
    }
}
