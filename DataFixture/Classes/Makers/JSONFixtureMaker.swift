//
//  JSONFixtureMaker.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation

public protocol JSONFixtureMaker: FixtureMaker {
    
    /// Create a JSON Array of models.
    /// - Parameter number: the number of JSON Object to make.
	func makeJSON(_ number: Int) -> [[String: Any]]
    
    /// Create a JSON Array from a sequence of models.
    /// - Parameter objects: the sequence to use.
    func makeJSON<S: Sequence>(from objects: S) -> [[String: Any]] where S.Element == Model
    
    /// Create an array of both model and its relative JSON Object.
    /// - Parameter number: the number of JSON Object/Model to make.
    func makeWithJSON(_ number: Int) -> [(object: Model, JSON: [String: Any])]
}

extension JSONFixtureMaker {
    
    /// Create a JSON Object.
    /// - Returns: a JSON Object.
	public func makeJSON() -> [String: Any] {
		return makeJSON(1).first!
	}
    
    /// Create a JSON Object from a model.
    /// - Parameter object: the model to use.
    /// - Returns: the JSON Array.
    public func makeJSON(from object: Model) -> [String: Any] {
        return makeJSON(from: [object]).first!
    }
    
    /// Create a tuple of model and its relative JSON Object.
    /// - Returns: the tuple of model + JSON Object.
    public func makeWithJSON() -> (object: Model, JSON: [String: Any]) {
        return makeWithJSON(1).first!
    }
}
