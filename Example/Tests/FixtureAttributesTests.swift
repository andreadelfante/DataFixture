//
//  FixtureAttributesTests.swift
//  DataFixture_Tests
//
//  Created by Andrea on 20/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import XCTest
import DataFixture

class FixtureAttributesTests: XCTestCase {
    private let key = "key"
    private let unexistedKey = "unexisted_key"
    private let value = 1
    private let defaultValue = -1
    private var attributes: FixtureAttributes!
    
    override func setUp() {
        super.setUp()
        
        attributes = FixtureAttributes(attributes: [key: value])
    }
    
    func testGetAttribute() {
        XCTAssertEqual(attributes[key], 1)
        XCTAssertNil(attributes[unexistedKey])
        XCTAssertEqual(attributes[key, nil], 1)
        XCTAssertNil(attributes[unexistedKey, nil])
    }
    
    func testGetAttributeWithDefaultValue() {
        XCTAssertEqual(attributes[key, defaultValue], value)
        XCTAssertEqual(attributes[unexistedKey, defaultValue], defaultValue)
        XCTAssertNil(attributes[unexistedKey])
    }
}
