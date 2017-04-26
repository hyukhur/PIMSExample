//
//  Reminder.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import Foundation

//private typealias Base = PIMS.Reminder
//private typealias Model = Base.Model

extension PIMS {
    enum Reminder {
        static var reminders:[PIMS.Reminder] = []
    }
}

extension PIMS.Reminder {
    enum Error: Swift.Error {
        case accessDefined
        case invalideState
        case nestedError(error: Swift.Error)
    }
}

extension PIMS.Reminder {
    struct Model {
        var reminderID: String
        var content: String
        var done: Bool
    }
}

extension PIMS.Reminder.Model: Equatable {
    static func ==(lhs: PIMS.Reminder.Model, rhs: PIMS.Reminder.Model) -> Bool {
        return lhs.reminderID == rhs.reminderID
    }
}

extension PIMS.Reminder.Model: PIMSCRUD { // CRUD
    typealias ValueObject = PIMS.Reminder.Model
    static var list: [ValueObject] = []
}
