// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataFixture",
    platforms: [.iOS(.v8)],
    products: [
        .library(
            name: "DataFixture",
            targets: ["DataFixture"]),
        .library(
            name: "DataFixture/RealmSeeder",
            targets: ["DataFixture/RealmSeeder"])
    ],
    dependencies: [
        .package(url: "https://github.com/vadymmarkov/Fakery.git", from: "4.0.0"),
        .package(url: "https://github.com/realm/realm-cocoa.git", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "DataFixture",
            dependencies: ["Fakery"],
            path: "DataFixture/Classes"),
        .target(
            name: "DataFixture/RealmSeeder",
            dependencies: ["RealmSwift"],
            path: "DataFixture-RealmSeeder/Classes"),

        .testTarget(
            name: "DataFixtureTests",
            dependencies: ["DataFixture", "DataFixture/RealmSeeder", "RealmSwift"],
            path: "Example/Tests"),
    ],
    swiftLanguageVersions: [.v5]
)
