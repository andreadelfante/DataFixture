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
    private let existedKeyWithNil = "existed_key_with_nil"
    private let value = 1
    private let defaultValue = -1
    private var attributes: FixtureAttributes!
    
    override func setUp() {
        super.setUp()
        
        let nilString: Int? = nil
        attributes = FixtureAttributes(attributes: [
            key: value,
            existedKeyWithNil: nilString as Any
        ])
    }
    
    func testGetAttribute() {
        XCTAssertEqual(attributes[key], 1)
        XCTAssertEqual(attributes[key, nil], 1)
        
        var unexisted: String? = attributes[unexistedKey]
        XCTAssertNil(unexisted)
        
        unexisted = attributes[unexistedKey, nil]
        XCTAssertNil(unexisted)
        
        unexisted = attributes[existedKeyWithNil]
        XCTAssertNil(unexisted)
        
        unexisted = attributes[existedKeyWithNil, nil]
        XCTAssertNil(unexisted)
    }
    
    func testGetAttributeWithDefaultValue() {
        XCTAssertEqual(attributes[key, defaultValue], value)
        XCTAssertEqual(attributes[unexistedKey, defaultValue], defaultValue)
        XCTAssertEqual(attributes[existedKeyWithNil, 1], 1)
        
        let unexisted: String? = attributes[unexistedKey]
        XCTAssertNil(unexisted)
    }
}
