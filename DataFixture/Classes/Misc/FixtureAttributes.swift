//
//  FixtureAttributes.swift
//  DataFixture
//
//  Created by Andrea on 15/01/2020.
//

import Foundation

/// A container of attributes, used to override default generation of value.
open class FixtureAttributes {
    public typealias Key = AnyHashable
    public typealias Value = Any

    private var attributes: [Key: Value]

    /// Create a new FixtureAttributes with some attributes.
    /// - Parameter attributes: a dictionary with a value associated by a key.
    public init(attributes: [Key: Value] = [:]) {
        self.attributes = attributes
    }

    /// Get an attributes with its key
    /// - Parameters:
    ///   - key: The key associated with the value
    /// - Returns: a value or nil if not presents or nil as value.
    public final subscript<T>(_ key: Key) -> T? {
        return attributes[key] as? T
    }
    
    /// Get an attributes with its key
    /// - Parameters:
    ///   - key: The key associated with the value
    ///   - defaultValue: A default value
    /// - Returns: a value or default value if not presents or nil as value.
    public final subscript<T>(_ key: Key, _ defaultValue: @autoclosure (() -> T?)) -> T? {
        guard let value = attributes[key] as? T else {
            return defaultValue()
        }
        return value
    }
}

extension FixtureAttributes: Sequence {
    public typealias Iterator = Dictionary<AnyHashable, Any>.Iterator

    public __consuming func makeIterator() -> Dictionary<AnyHashable, Any>.Iterator {
        return attributes.makeIterator()
    }
}

extension FixtureAttributes: CustomStringConvertible {
    public var description: String {
        return attributes.description
    }
}
