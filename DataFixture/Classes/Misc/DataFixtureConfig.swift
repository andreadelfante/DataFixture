//
//  DataFixtureConfig.swift
//  DataFixture
//
//  Created by Andrea on 24/01/2020.
//

import Foundation

/// A struct to define come configs of this library.
public struct DataFixtureConfig {

    /// Specify the language to generate fake data.
    /// - SeeAlso:
    /// [Fakery](https://github.com/vadymmarkov/Fakery)
    /// [Supported Languages](https://github.com/vadymmarkov/Fakery/tree/master/Resources/Locales)
    public static var locale = "en"

    /// Specify the default name for default fixture.
    public static let defaultName = "default"
}
