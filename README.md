# DataFixture

[![CI Status](https://img.shields.io/travis/andreadelfante/DataFixture.svg?style=flat)](https://travis-ci.org/andreadelfante/DataFixture)
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
1. Create a new file to define fixtures for each model.
```swift
import DataFixture

let factory = FixtureFactory()

// This is to define only a fixture for `Company` model
factory.define(for: Company.self, { (faker, attributes, resolver) -> Company in
    return Company(name: faker.company.name(),
                   employees: resolver.resolve(Person.self).create(10))
})

// This is to define only a fixture for `Company` model and its relative JSON Object, useful to fake network JSON responses.
factory.define(for: Company.self, { (faker, attributes, resolver) -> Company in
    Company(name: faker.company.name(),
            employees: resolver.resolve(Person.self).create(10))
}) { (object, resolver) -> [String : Any] in
    return [
        "name": object.name,
        "employees": resolver.resolve(Person.self).createJSON(from: object.employees)
    ]
}
```

2. Then you can call a fixture to build one or more fake models.
```swift
// This create a single object of type Company
factory.resolve(Company.self).create()

// This create 10 objects of type Company
factory.resolve(Company.self).create(10)
```

### Advanced
1. Create a `struct` to define a fixture.
```swift
import DataFixture

class PersonFixtureAttributes: FixtureAttributes { // Define this class if you want to override fields without guessing keys
    fileprivate static let firstNameKey = "firstName"
    fileprivate static let lastNameKey = "lastName"
    fileprivate static let birthdayKey = "birthday"
    fileprivate static let dogsKey = "dogs"
    
    init(firstName: String? = nil, lastName: String? = nil, birthday: Date? = nil, dogs: [Dog]? = nil) {
        super.init(attributes: [
            PersonFixtureAttributes.firstNameKey: firstName as Any,
            PersonFixtureAttributes.lastNameKey: lastName as Any,
            PersonFixtureAttributes.birthdayKey: birthday as Any,
            PersonFixtureAttributes.dogsKey: dogs as Any
        ])
    }
}

struct PersonFixture: JSONFixture { // `Fixture` to define only a fixture model. For fixtured JSONObject you must use `JSONFixture`.
    typealias Object = Person
    
    func fixture(faker: Faker, attributes: FixtureAttributes, resolver: FixtureResolver) -> Person {
        return Person(
            firstName: attributes[PersonFixtureAttributes.firstNameKey, faker.name.firstName()],
            lastName: attributes[PersonFixtureAttributes.lastNameKey, faker.name.lastName()],
            birthday: attributes[PersonFixtureAttributes.birthdayKey, faker.date.forward(10)],
            dogs: attributes[PersonFixtureAttributes.dogsKey, resolver.resolve(Dog.self).create(10)]
        ])
    }
    
    func jsonFixture(object: Person, resolver: FixtureResolver) -> [String : Any] {
        return [
            "firstName": object.firstName,
            "lastName": object.lastName,
            "birthday": object.birthday?.timeIntervalSince1970 as Any,
            "dogs": resolver.resolve(Dog.self).createJSON(from: object.dogs)
        ]
    }
}
```

2. Override FixtureFactory and define associations in `init()`.
```swift
import DataFixture

class FixtureFactory: DataFixture.FixtureFactory {
    override init() {
        super.init()
        
        define(Person.self, fixture: PersonFixture.self)
    }
}
```

3. Call the fixture with `factory`.
```swift
factory.resolve(Person.self).create()
factory.resolve(Person.self).create(PersonFixtureAttributes(firstName: "Luke")) // Create a person with firstName = Luke
factory.resolve(Person.self).create(3, PersonFixtureAttributes(firstName: "Luke")) // Create 3 persons with firstName = Luke
```

### Locale support
DataFixture uses [Fakery](https://github.com/vadymmarkov/Fakery) to generate fake data. Changing the locale of Fakery is quite simple: set the language using `DataFixtureConfig.locale = "<locale>"`. All supported locales are [here](https://github.com/vadymmarkov/Fakery/tree/master/Resources/Locales).

## RealmSeeder
This submodule can seed some data easily in [Realm](https://github.com/realm/realm-cocoa) Database, using Seeder.
First of all, define it in your Podfile `pod 'DataFixture/RealmSeeder'`. Then create a new `struct` to define a RealmSeeder.
```swift
import DataFixture

struct ExampleSeeder: RealmSeeder {
    func run(realm: Realm) throws {
        // Put here your database population
        
        realm.add(Person(firstName: "Luke"), update: .all) // You can simply create an object and then add in Realm instance.
        realm.add(factory.resolve(Dog.self).create(10), update: .all) // You can easily create 10 fake dogs and then add in Realm instance.
        
        try realm.seed(AnotherSeeder.self, AnotherAnotherSeeder.self) // To call another seed, please use this function to automatic handling transactions.
    }
}
```

To run the `ExampleSeeder` just call the **seed** function on a Realm instance. This function automatically starts a transaction if needed.
```swift
try realm.seed(ExampleSeeder.self)
```

## Documentation
Click [here](https://andreadelfante.github.io/DataFixture) to read the complete DataFixture API documentation.

## Contributing
DataFixture is an open source project, so feel free to contribute.
You can open an issue for problems or suggestions, and you can propose your own fixes by opening a pull request with the changes.
