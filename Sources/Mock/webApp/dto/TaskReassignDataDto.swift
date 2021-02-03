//
//  TaskReassignDataDto.swift
//  
//
//  Created by Tomasz Kucharski on 03/02/2021.
//

import Foundation

class TaskReassignDataListDto: Codable {
    var taskReassignDataDtoList: [TaskReassignDataDto]?
}


class TaskReassignDataDto: Codable {
    var resourceId: Int32?
    var fullUserName: String?
    var roleName: String?
    var userPhoneNumber: String?
    var email: String?
    var slotScope: TimeRangeDto?
    var variantScope: TimeRangeDto?
    var assigmentDates: TimeRangeDto?
}

extension TaskReassignDataDto {
    static func make(from userDto: UserDto) -> TaskReassignDataDto{
        let dto = TaskReassignDataDto()
        dto.resourceId = userDto.id
        dto.fullUserName = userDto.fullName
        dto.roleName = userDto.roleName
        
        let range = TimeRangeDto()
        range.dateFrom = Date().dateWithTime(hour: 10, minute: 0)
        range.dateTo = Date().dateWithTime(hour: 12, minute: 0)
        
        dto.slotScope = range
        dto.variantScope = range
        dto.assigmentDates = range
        dto.userPhoneNumber = "\(Int.random(in: 500...620))\(Int.random(in: 100...999))\(Int.random(in: 100...999))"
        return dto
    }
    
    static func makeGroup() -> TaskReassignDataDto{
        let dto = TaskReassignDataDto()
        dto.resourceId = Int32.random(in: 100...999)
        dto.fullUserName = RandomNameGenerator.randomName.capitalized
        dto.roleName = "Technician group"
        
        let range = TimeRangeDto()
        range.dateFrom = Date().dateWithTime(hour: 10, minute: 0)
        range.dateTo = Date().dateWithTime(hour: 12, minute: 0)
        
        dto.slotScope = range
        dto.variantScope = range
        dto.assigmentDates = range
        dto.userPhoneNumber = "\(Int.random(in: 500...620))\(Int.random(in: 100...999))\(Int.random(in: 100...999))"
        return dto
    }
}
