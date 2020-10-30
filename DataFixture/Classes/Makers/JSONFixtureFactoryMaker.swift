//
//  JSONFixtureFactoryMaker.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 30/10/2020.
//

import Foundation

public protocol JSONFixtureFactoryMaker: FixtureFactoryMaker {
	func makeJSON(_ number: Int) -> [[String: Any]]
}

extension JSONFixtureFactoryMaker {
	public func makeJSON() -> [String: Any] {
		return makeJSON(1).first!
	}
}

