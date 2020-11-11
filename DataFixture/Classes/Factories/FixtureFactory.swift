//
//  FixtureFactory.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation
import Fakery

/// This protocol specifies the definitions to create an object.
public protocol FixtureFactory: FixtureMaker {
    
    /// The default model definition.
    func definition() -> FixtureDefinition<Model>
}

extension FixtureFactory {
    
    /// Create a new model fixture definition.
    /// - Parameters:
    ///   - locale: the locale of the faker.
    ///   - definition: the definition closure.
    /// - Returns: a new model fixture definition.
    public func define(
        locale: String? = Locale.current.languageCode,
        _ definition: @escaping (Faker) -> Model
    ) -> FixtureDefinition<Model> {
        return FixtureDefinition(
            locale: locale,
            definition: definition
        )
    }
    
    /// Edit the default fixture definition.
    /// - Parameters:
    ///   - locale: the locale of the faker.
    ///   - redefinition: the redefinition closure.
    /// - Returns: a new model fixture definition with the specified edits.
    public func redefine(
        locale: String? = Locale.current.languageCode,
        _ redefinition: @escaping (inout Model) -> Void
    ) -> FixtureDefinition<Model> {
        return FixtureRedefinition(
            locale: locale,
            definition: definition().definition,
            redefinition: redefinition
        )
    }
}

// MARK: - FixtureFactoryMaker

extension FixtureFactory {
	public func make(_ number: Int) -> [Model] {
		return definition().make(number)
	}
}
