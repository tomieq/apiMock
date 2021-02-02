//
//  CalendarEventDto.swift
//  
//
//  Created by Tomasz Kucharski on 29/01/2021.
//

import Foundation

class CalendarEventListDto: Codable {
    
    var calendarVersion: String?
    var events: [CalendarEventDto] = []
    
    enum CodingKeys: String, CodingKey {
        case calendarVersion
        case events = "calendars"
    }
}

class CalendarEventDto: Codable {
    
    var id: Int32?
    var eventTypeId: Int32?
    var timeRange: TimeRangeDto?
    var taskId: Int32?
    var taskBusinessKey: String?
    var taskTypeName: String?
    var taskTypeId: Int32?
    var isTaskLocked: Bool?
    var orderTypeName: String?
    var address: String?
    var addressActionString: String?
    var priorityId: Int32?
}
