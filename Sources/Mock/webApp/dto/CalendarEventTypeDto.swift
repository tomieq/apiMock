//
//  CalendarEventTypeDto.swift
//  
//
//  Created by Tomasz Kucharski on 29/01/2021.
//

import Foundation


class CalendarEventTypeListDto: Codable {
    var list: [CalendarEventTypeDto]?
    enum CodingKeys: String, CodingKey {
        case list = "calendarEventTypes"
    }
}


class CalendarEventTypeDto: Codable {
    
    var id: Int32?
    var code: String?
    var name: String?
    var color: String?
    var backgroundType: String?
    var canBeCreated: Bool?
    var canBeEdited: Bool?
    var backgroundEvents : [Int32]?
}
