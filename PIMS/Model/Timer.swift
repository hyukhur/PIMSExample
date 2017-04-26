//
//  Timer.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import Foundation

//private typealias Base = PIMS.Timer
//private typealias Model = Base.Model

extension PIMS {
    struct Timer {
        static let timerLimit: TimeInterval = 60 * 60 * 24
        static var `default`: Model?

        var startDate: Date
        var interval: TimeInterval

        fileprivate var currentInterval: TimeInterval {
            return interval - (Date().timeIntervalSince1970 - startDate.timeIntervalSince1970 - 1)
        }

        static func isVaildTimerTime(start :Date, end: Date) -> Bool {
            let startTimeInterval = start.timeIntervalSince1970
            let endTimeInterval = end.timeIntervalSince1970

            let timeDiff = (endTimeInterval - startTimeInterval)
            return timeDiff < timerLimit
        }

//        var isValid: Bool {
//            return timer.isValid
//        }
//
//        var isFinished: Bool {
//            get {
//                return currentInterval - timer.timeInterval <= 0
//            }
//        }
//
//        lazy var timer: Timer = {
//            return Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(PIMSTimer.tictoc(timer:)), userInfo: nil, repeats: true)
//        }()
    }
}

extension PIMS.Timer {
    enum Error: Swift.Error {
        case accessDefined
        case invalideState
        case nestedError(error: Swift.Error)
    }
}

extension PIMS.Timer {
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

extension PIMS.Timer {
    struct Model: Equatable {
        var token: String
        var serverDate: Date
        var scheduledDate: Date

        static func ==(lhs: Model, rhs: Model) -> Bool {
            return lhs.token == rhs.token
        }
    }
}

extension PIMS.Timer.Model {

}

extension PIMS.Timer.Model: PIMSCRUD { // CRUD
    typealias ValueObject = PIMS.Timer.Model
    static var list: [ValueObject] = []
}
