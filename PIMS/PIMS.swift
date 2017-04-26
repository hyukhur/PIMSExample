//
//  PIMS.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import Foundation

//    FIXME
protocol PIMSCRUD {
    associatedtype ValueObject: Equatable
    static func save(object: ValueObject)
    static func find() -> [ValueObject]
    func update(object: ValueObject)
    func delete()
    static func deleteAll()

    static var list: [ValueObject] { get set }
}

extension PIMSCRUD where Self == ValueObject {
    static func save(object: ValueObject) { // FIXME: public typealias Model
        list.append(object)
    }
    static func find() -> [ValueObject] {
        return list
    }
    func update(object: ValueObject) {
        if let index = Self.list.index(where: { $0 == object }) {
            Self.list[index] = self
        }
    }
    func delete() {
        if let index = Self.list.index(where: { (each: ValueObject) in return each == self }) {
            Self.list.remove(at: index)
        }
    }
    static func deleteAll() {
        list = []
    }
}

enum PIMS {
//    FIXME
//    typealias CRUD = PIMSCRUD
}
