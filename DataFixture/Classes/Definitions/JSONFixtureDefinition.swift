//
//  JSONFixtureDefinition.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation
import Fakery

/// It defines a fixture to generate the model and the associated JSON.
public class JSONFixtureDefinition<Model: FixtureFactoryable>: JSONFixtureMaker {
	internal let fixtureDefinition: FixtureDefinition<Model>
    internal let JSONDefinition: (Model) -> [String: Any]
	
	internal init(
        fixtureDefinition: FixtureDefinition<Model>,
        JSONDefinition: @escaping (Model) -> [String: Any]
    ) {
        self.fixtureDefinition = fixtureDefinition
        self.JSONDefinition = JSONDefinition
	}
    
    public func make(_ number: Int) -> [Model] {
        return fixtureDefinition.make(number)
    }
    
    public func makeJSON(_ number: Int) -> [[String : Any]] {
        return (0..<number)
            .map { (_) in JSONDefinition(fixtureDefinition.make()) }
    }
    
    public func makeJSON<S>(from objects: S) -> [[String : Any]] where S : Sequence, Model == S.Element {
        return objects.map { JSONDefinition($0) }
    }
    
    public func makeWithJSON(_ number: Int) -> [(object: Model, JSON: [String : Any])] {
        return (0..<number)
            .map { (_) in
                let model = fixtureDefinition.make()
                let JSON = JSONDefinition(model)
                return (model, JSON)
            }
    }
}
