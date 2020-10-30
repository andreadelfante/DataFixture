//
//  FixtureFactory.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation

public protocol FixtureFactory: FixtureFactoryMaker {
	associatedtype Model
	
	func definition() -> FixtureFactoryDefinition<Model>
}

extension FixtureFactory {
	public func fixture
}

// MARK: - FixtureFactoryMaker

extension FixtureFactory {
	public func make(_ number: Int) -> [Model] {
		return definition().make(number)
	}
}
