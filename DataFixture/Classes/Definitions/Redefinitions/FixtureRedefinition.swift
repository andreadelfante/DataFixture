//
//  FixtureRedefinition.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 02/11/2020.
//

import Foundation
import Fakery

internal class FixtureRedefinition<Model: FixtureFactoryable>: FixtureDefinition<Model> {
    private let redefinition: (inout Model) -> Void
    
    internal init(
        locale: String?,
        definition: @escaping (Faker) -> Model,
        redefinition: @escaping (inout Model) -> Void
    ) {
        self.redefinition = redefinition
        super.init(locale: locale, definition: definition)
    }

    override func make(_ number: Int) -> [Model] {
        return (0..<number)
            .map { (_) in
                var model = definition(faker)
                redefinition(&model)
                return model
            }
    }
}
