//
//  JSONFixtureFactoryDefinition.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation
import Fakery

public class JSONFixtureFactoryDefinition<Model> {
	private let definition: (Faker, Model) -> [String: Any]
	private var faker: Faker
	
	public init(definition: @escaping (Faker, Model) -> [String: Any]) {
		self.definition = definition
		self.faker = Faker()
	}
	
	public func locale(_ locale: String) -> Self {
		self.faker = Faker(locale: locale)
		return self
	}
}

// MARK: - JSONFixtureFactoryMaker

extension JSONFixtureFactoryDefinition: JSONFixtureFactoryMaker {
	public func makeJSON(_ number: Int) -> [[String : Any]] {
		return (0..<number)
			.map { (_) in
				let model = 
			}
	}
}
