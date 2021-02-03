//
//  WorkOrderTypeForCreationDto.swift
//  
//
//  Created by Tomasz Kucharski on 03/02/2021.
//

import Foundation

class WorkOrderTypesForCreationListDto: Codable {
    var workOrderTypesForCreation: [WorkOrderTypeForCreationDto]?
}

class WorkOrderTypeForCreationDto: Codable {
    var typeId: Int32?
    var technologiesForCreation: [TechnologyForCreationDto]?
}

class TechnologyForCreationDto: Codable {
    var technologyId: Int32?
    var technologyName: String?
    var taskTypesForCreation: [TaskTypeForCreationDto]?
}

class TaskTypeForCreationDto: Codable {
    var typeId: Int32?
}
