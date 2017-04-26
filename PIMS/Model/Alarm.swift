//
//  Alarm.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import Foundation
import UserNotifications

//private typealias Base = PIMS.Alarm
//private typealias Model = Base.Model

extension PIMS {
    enum Alarm {
        fileprivate static var alarms:[Model] = []
    }
}

extension PIMS.Alarm {
    enum Error: Swift.Error {
        case accessDefined
        case nestedError(error: [Swift.Error])
    }
}

extension PIMS.Alarm {
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
        var dateComponents: DateComponents {
            let weekday: Int = {
                switch self {
                case  .sunday:
                    return 0
                case .monday:
                    return 1
                case .tuesday:
                    return 2
                case .wednesday:
                    return 3
                case .thursday:
                    return 4
                case .friday:
                    return 5
                case .saturday:
                    return 6
                }
                }() + Weekday.firstWeekday
            return DateComponents(weekday: weekday)
        }
        static let calendar = Calendar(identifier: .gregorian)
        static let firstWeekday = calendar.firstWeekday // SUNDAY and 1

        static let weekends = Set<Weekday>([.sunday, saturday])
        static let weekdays = Set<Weekday>([.monday, .tuesday, .wednesday, .thursday, .friday])
        static var week = Set<Weekday>([.monday, .tuesday, .wednesday, .thursday, .friday, .saturday, .sunday])

        public static func confirmWeekDays(weekdays weekdaysValue: [Weekday]) -> Bool {
            return Weekday.weekdays == Set(weekdaysValue)
        }

        public static func confirmWeekends(weekends weekendsValue: [Weekday]) -> Bool {
            return Weekday.weekends == Set(weekendsValue)
        }

        public static func confirmWeek(week weekValue: [Weekday]) -> Bool {
            return Weekday.week == Set(weekValue)
        }
    }
}


extension PIMS.Alarm {
    struct Model: Equatable {
        static func ==(lhs: Model, rhs: Model) -> Bool {
            return lhs.token == rhs.token
        }
        struct Period {
            var scheduledDate: Date
            var weekdays: [Weekday]?
        }
        fileprivate var notificationRequestIdentifier: [String] = []
        fileprivate var token: String
        var period: Period
        var active: Bool {
            return notificationRequestIdentifier.isEmpty == false
        }
        var registerdDate: Date? = nil

        var coding: Coding {
            return Coding(alarm: self)
        }
        init(token: String, period: Period) {
            self.token = token
            self.period = period
            registerdDate = Date()
        }
    }
    class Coding: NSObject, NSCoding {
        var alarm: Model

        init(alarm alarmValue: Model) {
            alarm = alarmValue
            super.init()
        }

        static let identifierKey = "notificationRequestIdentifierKey"
        static let tokenKey = "tokenKey"
        static let scheduledKey = "scheduledKey"
        static let weekdaysKey = "weekdaysKey"
        static let localNotificationsKey = "localNotificationsKey"

        func encode(with aCoder: NSCoder) {
            if alarm.notificationRequestIdentifier.isEmpty == false {
                aCoder.encode(alarm.notificationRequestIdentifier, forKey: Coding.identifierKey)
            }
            aCoder.encode(alarm.token, forKey: Coding.tokenKey)
            aCoder.encode(alarm.period.scheduledDate.timeIntervalSince1970, forKey: Coding.scheduledKey)
            if let weekdays = alarm.period.weekdays {
                aCoder.encode(weekdays.map { $0.rawValue }, forKey: Coding.weekdaysKey)
            }
        }

        required convenience init?(coder aDecoder: NSCoder) {
            guard let token = aDecoder.decodeObject(forKey: Coding.tokenKey) as? String else { return nil }

            guard aDecoder.containsValue(forKey:Coding.scheduledKey) else { return nil }
            let scheduled = aDecoder.decodeDouble(forKey: Coding.scheduledKey)
            let scheduledDate = Date(timeIntervalSince1970: scheduled)

            let weekdays = (aDecoder.decodeObject(forKey: Coding.weekdaysKey) as? [String])?.flatMap { Weekday(rawValue: $0) }

            self.init(alarm: Model(token: token, period: Model.Period(scheduledDate: scheduledDate, weekdays: weekdays)))

            if let notificationRequestIdentifier = aDecoder.decodeObject(forKey: Coding.identifierKey) as? [String] {
                alarm.notificationRequestIdentifier = notificationRequestIdentifier
            }
        }
    }
}

private typealias Coding = PIMS.Alarm.Coding
extension PIMS.Alarm.Model {
    var newCoding: PIMS.Alarm.Coding {
        return Coding(alarm: self)
    }
}

extension PIMS.Alarm.Model: PIMSCRUD { // CRUD
    typealias ValueObject = PIMS.Alarm.Model
    static var list: [ValueObject] = []
}
