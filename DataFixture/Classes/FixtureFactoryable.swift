//
//  FixtureFactoryable.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation

/// Allow the model to define his own factory.
public protocol FixtureFactoryable {
	associatedtype Factory: FixtureFactory
    
    /// Get a new factory instance for the model.
    static var factory: Factory { get }
}
