//
//  Company.swift
//  DataFixture_Tests
//
//  Created by Andrea Del Fante on 06/11/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import DataFixture

struct Company {
    let name: String
    let employees: [Person]
}

// MARK: - Fixture

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
    
    func jsonDefinition() -> JSONFixtureDefinition<Company> {
        defineJSON { (company) -> [String : Any] in
            [
                "name": company.name,
                "employees": Person.factory.makeJSON(from: company.employees)
            ]
        }
    }
    
    func empty(name: String) -> FixtureDefinition<Company> {
        define { (faker) in
            Company(name: name, employees: [])
        }
    }
}
