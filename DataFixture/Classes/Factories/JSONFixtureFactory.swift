//
//  JSONFixtureFactory.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 31/10/2020.
//

import Foundation

/// This protocol defines the rules to create a JSON Object from an object.
public protocol JSONFixtureFactory: FixtureFactory, JSONFixtureMaker {
    
    /// The default JSON model definition.
    func jsonDefinition() -> JSONFixtureDefinition<Model>
}

extension JSONFixtureFactory {
    
    /// Create a new JSON model fixture definition.
    /// - Parameters:
    ///   - modelDefinition: the model definition to use for the JSON definition.
    ///   - definition: the JSON definition closure.
    /// - Returns: a new JSON model fixture definition.
    public func defineJSON(
        _ modelDefinition: FixtureDefinition<Model>? = nil,
        _ JSONDefinition: @escaping (Model) -> [String: Any]
    ) -> JSONFixtureDefinition<Model> {
        return JSONFixtureDefinition(
            fixtureDefinition: modelDefinition ?? self.definition(),
            JSONDefinition: JSONDefinition
        )
    }
    
    /// Edit the default JSON fixture definition.
    /// - Parameters:
    ///   - redefinition: the redefinition closure.
    /// - Returns: a new JSON model fixture definition with the specified edits.
    public func redefine(_ redefinition: @escaping (Model) -> Model) -> JSONFixtureDefinition<Model> {
        return JSONFixtureDefinition(
            fixtureDefinition: redefine(redefinition),
            JSONDefinition: jsonDefinition().JSONDefinition
        )
    }
}

// MARK: - JSONFixtureMaker

extension JSONFixtureFactory {
    public func makeJSON(_ number: Int) -> [[String : Any]] {
        return jsonDefinition().makeJSON(number)
    }
    
    public func makeJSON<S>(from objects: S) -> [[String : Any]] where S : Sequence, Model == S.Element {
        return jsonDefinition().makeJSON(from: objects)
    }
    
    public func makeWithJSON(_ number: Int) -> [(object: Model, JSON: [String : Any])] {
        return jsonDefinition().makeWithJSON(number)
    }
}
