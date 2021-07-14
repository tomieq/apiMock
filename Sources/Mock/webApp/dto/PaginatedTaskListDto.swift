//
//  PaginatedTaskListDto.swift
//  
//
//  Created by Tomasz Kucharski on 19/03/2021.
//

import Foundation

class PaginatedTaskListDto: Codable {
    var currentPage: Int?
    var pageAmount: Int?
    var tasks: [BasicTaskDto]?

    enum CodingKeys: String, CodingKey {
        case currentPage = "pageNumber"
        case pageAmount = "pageAmount"
        case tasks = "basicTaskDtoList"
    }
}

class BasicTaskDto: Codable {
    
    var id: Int32?
    var bussinesKey: String?
    var statusId: Int32?
    var taskTypeId: Int32?
    var workOrderTypeId: Int32?
    var additionalInformationMap: [String: String]?
    var scheduledRealizationTime: TimeRangeDto?
    var timeZone: String?
    var flagIds: [Int32]?
    var priorityId: Int32?
    var slaDate: Date?
    var technologyId: Int32?
    var isTaskLocked: Bool?
    var location: LocationDto?
    
   enum CodingKeys: String, CodingKey {
       case id = "taskId"
       case bussinesKey = "taskBusinessKey"
       case statusId = "taskStatusId"
       case taskTypeId = "taskTypeId"
       case workOrderTypeId = "workOrderTypeId"
       case additionalInformationMap = "additionalInformationMap"
       case scheduledRealizationTime = "scheduledRealizationTime"
       case timeZone = "timezone"
       case flagIds = "flagIds"
       case priorityId = "priorityId"
       case slaDate = "slaDate"
       case technologyId = "technologyId"
       case isTaskLocked = "isTaskLocked"
       case location = "locationDto"
   }
}

extension BasicTaskDto {
    convenience init(taskDto dto: TaskDto) {
        self.init()
        self.id = dto.id
        self.bussinesKey = dto.bussinesKey
        self.statusId = dto.statusId
        self.taskTypeId = dto.typeId
        self.workOrderTypeId = dto.workOrderTypeId
        self.additionalInformationMap = dto.additionalInformationMap
        self.scheduledRealizationTime = dto.scheduledRealizationTime
        self.timeZone = dto.timeZone
        self.flagIds = dto.flagIds
        self.priorityId = dto.priorityId
        self.slaDate = dto.slaDate
        self.technologyId = dto.technologyId
        self.isTaskLocked = dto.isTaskLocked
        self.location = dto.location
    }
}
