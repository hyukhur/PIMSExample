//
//  Memo.swift
//  PIMS
//
//  Created by hyukhur on 16/04/2017.
//  Copyright © 2017 hyukhur. All rights reserved.
//

import Foundation

//private typealias Base = PIMS.Memo
//private typealias Model = Base.Model

extension PIMS {
    struct Memo {
        static var memos:[PIMS.Memo] = []
    }
}

extension PIMS.Memo {
    enum Error: Swift.Error {
        case accessDefined
        case invalideState
        case nestedError(error: Swift.Error)
    }
}

func ==(lhs: PIMS.Memo.Model, rhs: PIMS.Memo.Model) -> Bool {
    return lhs.memoID == rhs.memoID
}

extension PIMS.Memo {
    struct Model: Equatable {
        var memoID: String
        var content: String
        var title: String?
        var createDate: Date?

        public init(memoID memoIDValue: String, title titleValue: String? = nil, content contentValue: String, createDate createDateValue: Date?) {
            memoID = memoIDValue
            content = contentValue
            if let title = titleValue, title.isEmpty == false {
                self.title = title
            }
            createDate = createDateValue
        }
    }
}

extension PIMS.Memo { // CRUD
    
}

extension PIMS.Memo.Model: PIMSCRUD { // CRUD
    typealias ValueObject = PIMS.Memo.Model
    static var list: [ValueObject] = []
}
