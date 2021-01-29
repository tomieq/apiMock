//
//  DictionaryDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class DictionaryListDto: Codable {
    var list: [DictionaryDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "dictionaries"
    }
}


class DictionaryDto: Codable {
    
    var id: Int32?
    var entryId: Int32?
    var dictionaryName: String?
    var code: String?
    var value: String?
    var dateFrom: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_dateFrom)
        }
        set(newDate) {
            _dateFrom = MobileApiDateTransform().transformToJSON(newDate)
        }
    }
    var dateTo: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_dateTo)
        }
        set(newDate) {
            _dateTo = MobileApiDateTransform().transformToJSON(newDate)
        }
    }
    private var _dateFrom: Double?
    private var _dateTo: Double?
    var parentIds: [Int32]?
    var attributes: [DictionaryAttributeDto]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case entryId
        case dictionaryName
        case code
        case value
        case _dateFrom = "dateFrom"
        case _dateTo = "dateTo"
        case parentIds
        case attributes
    }
}


class DictionaryAttributeDto: Codable {
    
    var code: String?
    var type: String?
    
    var stringValue: String?
    var booleanValue: Bool?
    var intValue: Int32?
    var dateValue: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_dateValue)
        }
        set(newDate) {
            _dateValue = MobileApiDateTransform().transformToJSON(newDate)
        }
    }
    private var _dateValue: Double?
    var floatValue: Float?
    
    enum CodingKeys: String, CodingKey {
        case code = "attributeDefinitionCode"
        case type
        case stringValue
        case booleanValue
        case intValue
        case _dateValue = "dateValue"
        case floatValue
    }
}
