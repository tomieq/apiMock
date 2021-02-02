//
//  CalendarUpdateResultDto.swift
//  
//
//  Created by Tomasz Kucharski on 29/01/2021.
//

import Foundation

class CalendarUpdateResultDto: Codable {
    
    var id: Int32?
    var calendarVersion: String?
    var info: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case calendarVersion = "version"
        case info = "additionalRestrictionViolationsInfo"
    }
}
