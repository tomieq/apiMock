//
//  ItemValueDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class ItemValueDto: Codable {
    var type: String?
    var valueId: Int32?
    var stringValue: String?
    var dateValue: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_dateValue)
        }
        set(newDate) {
            _dateValue = MobileApiDateTransform().transformToJSON(newDate)
        }
    }
    private var _dateValue: Double?
    var booleanValue: Bool?
    var longValue: Int32?
    var intValue: Int32?
    var doubleValue: Double?
    var isItemChosen: Bool?
    var longitude: Double?
    var latitude: Double?
    
    enum CodingKeys: String, CodingKey {
        case type
        case valueId
        case stringValue
        case _dateValue = "dateValue"
        case booleanValue
        case longValue
        case intValue
        case doubleValue
        case isItemChosen
        case longitude
        case latitude
    }
}
