//
//  FixtureDefinition.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation
import Fakery

/// It defines a fixture to generate the model.
public class FixtureDefinition<Model: FixtureFactoryable>: FixtureMaker {
	internal let definition: (Faker) -> Model
	internal var faker: Faker
	
	internal init(
        locale: String?,
        definition: @escaping (Faker) -> Model
    ) {
		self.definition = definition
		
        if let locale = locale {
            self.faker = Faker(locale: locale)
        } else {
            self.faker = Faker()
        }
	}
    
    public func make(_ number: Int) -> [Model] {
        return (0..<number)
            .map { (_) in definition(faker) }
    }
}
