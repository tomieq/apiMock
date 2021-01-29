//
//  File.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class TimeRangeDto: Codable {
    
    var dateFrom: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_dateFrom)
        }
        set(newDateFrom) {
            _dateFrom = MobileApiDateTransform().transformToJSON(newDateFrom)
        }
    }
    private var _dateFrom: Double?
    var dateTo: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_dateTo)
        }
        set(newDateTo) {
            _dateTo = MobileApiDateTransform().transformToJSON(newDateTo)
        }
    }
    private var _dateTo: Double?
    
    enum CodingKeys: String, CodingKey {
        case _dateFrom = "dateFrom"
        case _dateTo = "dateTo"
    }
}
