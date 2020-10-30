//
//  FixtureFactoryDefinition.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation
import Fakery

public class FixtureFactoryDefinition<Model> {
	private let definition: (Faker) -> Model
	private var faker: Faker
	
	public init(definition: @escaping (Faker) -> Model) {
		self.definition = definition
		self.faker = Faker()
	}
	
	public func locale(_ locale: String) -> Self {
		self.faker = Faker(locale: locale)
		return self
	}
}

// MARK: - FixtureFactoryMaker

extension FixtureFactoryDefinition: FixtureFactoryMaker {
	public func make(_ number: Int) -> [Model] {
		return (0..<number)
			.map { (_) in definition(faker) }
	}
}
