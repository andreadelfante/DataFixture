//
//  FixtureFactoryable.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation

public protocol FixtureFactoryable {
	associatedtype Factory: FixtureFactory
	
	static func factory() -> Factory
}
