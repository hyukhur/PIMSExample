//
//  Event.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import Foundation
import EventKit

//private typealias Base = PIMS.Event
//private typealias Model = Base.Model

extension PIMS {
    enum Event {
        static let store = EKEventStore()
        static let calendar = NSCalendar.current

        private static var __calendars: [EKCalendar]?
        static var calendars: [EKCalendar]? {
            get {
                guard let calendars = __calendars else {
                    let calendar =  store.calendars(for: .event)
                    __calendars = calendar
                    return calendar
                }
                return calendars
            }
            set {
                __calendars = calendars
            }
        }
    }
}

extension PIMS.Event {
    enum Error: Swift.Error {
        case accessDefined
        case invalideState
        case nestedError(error: Swift.Error)
    }
}

extension PIMS.Event {
    enum Period: String {
        case none, year, month, week, day, hour, minute
        var dateComponents: DateComponents {
            switch self {
            case .year:
                return DateComponents(year: 1)
            case .month:
                return DateComponents(month: 1)
            case .week:
                return DateComponents(weekOfYear: 1)
            case .day:
                return DateComponents(day: 1)
            case .hour:
                return DateComponents(hour: 1)
            case .minute:
                return DateComponents(minute: 1)
            default:
                return DateComponents()
            }
        }
        static let calendar = NSCalendar.current
        func endDate(startDate: Date) -> Date? {
            return Period.calendar.date(byAdding: dateComponents, to: startDate)
        }
    }
}

extension PIMS.Event {
    static var newValue = store.calendars(for: .event)
    struct DateRange {
        var predicate: NSPredicate {
            return store.predicateForEvents(withStart: startDate, end: endDate ?? startDate, calendars: PIMS.Event.calendars)
        }
        let startDate: Date
        let period: Period

        var endDate: Date? {
            return period.endDate(startDate: startDate)
        }

    }
}

extension PIMS.Event {
    struct Model: Equatable {
        var title: String
        var issueID: String
        var dateRange: DateRange
        var event: EKEvent?

        init(dateRange: DateRange, title: String, issueID: String = UUID().uuidString) {
            self.dateRange = dateRange
            self.title = title
            self.issueID = issueID
        }

        init(event: EKEvent) {
            self.dateRange = DateRange(startDate: event.startDate, period: event.isAllDay ? .day : .none)
            self.title = event.title
            self.issueID = event.eventIdentifier
        }

    }
    fileprivate static var list: [Model] = []
}

func ==(lhs: PIMS.Event.Model, rhs: PIMS.Event.Model) -> Bool {
    return lhs.issueID == rhs.issueID
}

extension PIMS.Event.Model: PIMSCRUD { // CRUD
    typealias ValueObject = PIMS.Event.Model
    static var list: [ValueObject] = []
}
