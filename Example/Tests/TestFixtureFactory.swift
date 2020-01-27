//
//  TestFixtureFactory.swift
//  DataFixture_Tests
//
//  Created by Andrea on 15/01/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import DataFixture

class TestFixtureFactory: FixtureFactory {
    override init() {
        super.init()
        
        define(for: Person.self, fixture: PersonFixture.self)
        define(for: Dog.self, fixture: DogFixture.self)
    }
}
