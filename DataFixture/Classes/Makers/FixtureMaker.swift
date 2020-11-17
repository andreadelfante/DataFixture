//
//  FixtureMaker.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation

/// This protocol define a fixture maker.
public protocol FixtureMaker {
    associatedtype Model: FixtureFactoryable
	
    /// Create an array of models.
    /// - Parameter number: the number of models to make.
    /// - Returns: the array of models.
	func make(_ number: Int) -> [Model]
}

extension FixtureMaker {
    
    /// Create a model.
    /// - Returns: the model.
	public func make() -> Model {
		return make(1).first!
	}
}
