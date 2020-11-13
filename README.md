# DataFixture

![SwiftEssentialsKit CI](https://github.com/andreadelfante/DataFixture/workflows/DataFixture%20CI/badge.svg)
[![Version](https://img.shields.io/cocoapods/v/DataFixture.svg?style=flat)](https://cocoapods.org/pods/DataFixture)
[![License](https://img.shields.io/cocoapods/l/DataFixture.svg?style=flat)](https://cocoapods.org/pods/DataFixture)
[![Platform](https://img.shields.io/cocoapods/p/DataFixture.svg?style=flat)](https://cocoapods.org/pods/DataFixture)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat)](https://github.com/dwyl/esta/issues)

Create data models easily, with no headache. DataFixture is a convenient way to generate new data for testing / seeding your Realm Database.

## Installation
### Cocoapods
> CocoaPods 0.39.0+ is required to build this library

To install DataFixture, simply add in your Podfile `pod 'DataFixture'` and run `pod install`

## Usage
### Basic
1. Create a new file to define the fixture factory for a model.
```swift
import DataFixture

extension Company: FixtureFactoryable {
    static var factory: CompanyFixtureFactory {
        return CompanyFixtureFactory()
    }
}

struct CompanyFixtureFactory: FixtureFactory {
    typealias Model = Company
    
    func definition() -> FixtureDefinition<Company> {
        define { (faker) in
            Company(
                name: faker.company.name(),
                employees: Person.factory.make(5)
            )
        }
    }
    
    // If you need to override a model field, simply define a function that returns a `FixtureDefinition`.
    // To redefine the default definition, you must use the `redefine` function.
    func empty(name: String) -> FixtureDefinition<Company> {
        redefine { (company) in
            company.name = name
        }
    }
}
```

2. Then you can build the model by using its factory.
```swift
// Create a single object of type Company.
Company.factory.makeJSON()
// Create a single object of type Company with no employees.
Company.factory.empty(name: "EmptyCompany").make()

// Create 10 objects of type Company.
Company.factory.make(10)
// Create 10 objects of type Company with no employees.
Company.factory.empty(name: "EmptyCompany").make(10)
```

### JSON Fixtures
A factory can create a JSON Object from a generated model.
1. First, you have to extend `JSONFixtureFactory` protocol to the model factory.
```swift
import DataFixture

extension Company: FixtureFactoryable {
    static var factory: CompanyFixtureFactory {
        return CompanyFixtureFactory()
    }
}

struct CompanyFixtureFactory: JSONFixtureFactory {
    typealias Model = Company
    
    func definition() -> FixtureDefinition<Company> {
        define { (faker) in
            Company(
                name: faker.company.name(),
                employees: Person.factory.make(5)
            )
        }
    }
    
    // This function define the json definition, using the default definition (function `definition()`).
    func jsonDefinition() -> JSONFixtureDefinition<Company> {
        defineJSON { (company) -> [String : Any] in
            [
                "name": company.name,
                "employees": Person.factory.makeJSON(from: company.employees)
            ]
        }
    }
    
    // If you need to generate the JSON Object of an empty company, change the return type to `JSONFixtureDefinition`
    func empty(name: String) -> JSONFixtureDefinition<Company> { // Previously `FixtureDefinition`
        redefine { (company) in
            company.name = name
        }
    }
}
```

2. Now you can generate the JSON Object of the model.
```swift
// Create a single JSON object of type Company.
Company.factory.makeJSON()
// Create a single JSON object of type Company with no employees.
Company.factory.empty(name: "EmptyCompany").makeJSON()

// Create a JSON Array of 10 objects of type Company.
Company.factory.makeJSON(10)
// Create a JSON Array of 10 objects of type Company with no employees.
Company.factory.empty(name: "EmptyCompany").makeJSON(10)

// Create a Company object with its relative JSON object.
Company.factory.makeWithJSON()
// Create 10 Company object with its relative JSON objects.
Company.factory.makeWithJSON(10)
```

3. With `JSONFixtureFactory` you can create a JSON from an external model object.
```swift
let company = Company.factory.make()
let JSONObject = Company.factory.makeJSON(from: company)

let companies = Company.factory.make(3)
let JSONArray = Company.factory.makeJSON(from: companies)
```

## RealmSeeder
This submodule can seed some data easily in [Realm](https://github.com/realm/realm-cocoa) Database, using Seeder.
First of all, define it in your Podfile `pod 'DataFixture/RealmSeeder'`. Then create a new `struct` to define a RealmSeeder.
```swift
import DataFixture

struct ExampleSeeder: RealmSeeder {
    func run(realm: Realm) throws {
        // Put here your database population
        
        realm.add(Person(firstName: "Luke"), update: .all) // You can simply create an object and then add in Realm instance.
        try Dog.factory.create(10, in: realm) // You can easily create 10 fake dogs and then add in Realm instance.
        
        try realm.seed(AnotherSeeder.self, AnotherAnotherSeeder.self) // To call another seed, please use this function to automatic handling transactions.
    }
}
```

To run the `ExampleSeeder` just call the **seed** function on a Realm instance. This function automatically starts a transaction if needed.
```swift
try realm.seed(ExampleSeeder.self)
```

## Documentation
Click [here](https://andreadelfante.github.io/DataFixture/index.html) to read the complete DataFixture API documentation.

## Contributing
DataFixture is an open source project, so feel free to contribute.
You can open an issue for problems or suggestions, and you can propose your own fixes by opening a pull request with the changes.
