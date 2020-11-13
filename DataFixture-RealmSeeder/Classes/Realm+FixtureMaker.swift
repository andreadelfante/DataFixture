//
//  Realm+FixtureMaker.swift
//  DataFixture
//
//  Created by Andrea Del Fante on 11/11/2020.
//

import RealmSwift
#if SWIFT_PACKAGE
import DataFixture
#endif

extension FixtureMaker where Model: Object {
    
    /// Make a collection of models and persist them into Realm.
    /// - Parameters:
    ///   - number: the number of models to make.
    ///   - realm: the realm the model is saved in.
    /// - Returns: the saved models
    @discardableResult
    public func create(_ number: Int, in realm: Realm) throws -> [Model] {
        let models = make(number)
        try realm.safeWrite { realm.add(models) }
        return models
    }
    
    /// Make a single model and persist it into Realm.
    /// - Parameter realm: the realm the model is saved in.
    /// - Returns: the saved model.
    @discardableResult
    public func create(in realm: Realm) throws -> Model {
        return try create(1, in: realm).first!
    }
}
