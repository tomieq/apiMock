//
//  TaskRealTimeDatesInfoDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class TaskRealTimeDatesInfoDto: Codable {
    var realTimeDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_realTimeDate)
        }
        set(newRealTimeDate) {
            _realTimeDate = MobileApiDateTransform().transformToJSON(newRealTimeDate)
        }
    }
    private var _realTimeDate: Double?
    var registeredTimeDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_registeredTimeDate)
        }
        set(newRegisteredTimeDate) {
            _registeredTimeDate = MobileApiDateTransform().transformToJSON(newRegisteredTimeDate)
        }
    }
    private var _registeredTimeDate: Double?
    
    enum CodingKeys: String, CodingKey {
        case _realTimeDate = "userRegisteredTimeDate"
        case _registeredTimeDate = "appRegisteredTimeDate"
    }
}
