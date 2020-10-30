//
//  FixtureFactoryMaker.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation

public protocol FixtureFactoryMaker {
	associatedtype Model
	
	func make(_ number: Int) -> [Model]
}

extension FixtureFactoryMaker {
	public func make() -> Model {
		return make(1).first!
	}
}
