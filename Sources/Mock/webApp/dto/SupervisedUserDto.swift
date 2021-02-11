//
//  SupervisedUserDto.swift
//  
//
//  Created by Tomasz Kucharski on 11/02/2021.
//

import Foundation

class SupervisedUserDtoList: Codable {
    var users: [SupervisedUserDto]?
}

class SupervisedUserDto: Codable {
    
    var id: Int32?
    var login: String?
    var fullName: String?
    var firstName: String?
    var roleCode: String?
    var roleName: String?
    var timeZone: String?
    var otpEnabled: Bool?
    var userWorkStatus: UserWorkStatusDto?
    var phoneNumber: String?
    var tasks: [TaskSimpleDto]?
    var employeePosition: EmployeePositionDto?
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case fullName
        case firstName
        case roleCode
        case roleName
        case timeZone
        case phoneNumber
        case userWorkStatus
        case tasks
        case employeePosition = "position"
    }
    
    static func make(userDto: UserDto) -> SupervisedUserDto {
        let dto = SupervisedUserDto()
        dto.id = userDto.id
        dto.login = userDto.login
        dto.fullName = userDto.fullName
        dto.firstName = userDto.firstName
        dto.roleCode = userDto.roleCode
        dto.roleName = userDto.roleName
        dto.timeZone = userDto.timeZone
        dto.userWorkStatus = userDto.userWorkStatus
        dto.phoneNumber = ((dto.id ?? 0) % 2 == 0 ? nil : "603 782 907")
        dto.tasks = []
        return dto
    }
}

class EmployeePositionDto: Codable {
    
    
    var longitude: Double?
    var latitude: Double?
    var lastPositionTime: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_lastPositionTime)
        }
        set(newLastPositionTime) {
            _lastPositionTime = MobileApiDateTransform().transformToJSON(newLastPositionTime)
        }
    }
    private var _lastPositionTime: Double?
    
    enum CodingKeys: String, CodingKey {
        case longitude
        case latitude
        case _lastPositionTime = "lastPositionTime"
    }
    
    static func make(_ positionDto: GpsPositionDto?) -> EmployeePositionDto? {
        guard let position = positionDto else { return nil }
        let dto = EmployeePositionDto()
        dto.longitude = position.longitude
        dto.latitude = position.latitude
        dto.lastPositionTime = position.captureDate
        return dto
    }
}

class TaskSimpleDto: Codable {
    
    var externalId: Int32?
    var workOrderTypeId: Int32?
    var taskTypeId: Int32?
    var businessKey: String?
    var statusId: Int32?
    var priorityId: Int32?
    var timeZone: String?
    var location: LocationDto?
    var realizationTime: TimeRangeDto?
    var tehnologyName: String?
    var slaDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_slaDate)
        }
        set(newSlaDate) {
            _slaDate = MobileApiDateTransform().transformToJSON(newSlaDate)
        }
    }
    private var _slaDate: Double?
    
    enum CodingKeys: String, CodingKey {
        case externalId = "id"
        case workOrderTypeId
        case taskTypeId
        case businessKey
        case statusId
        case priorityId
        case timeZone
        case location
        case realizationTime
        case _slaDate = "slaDate"
    }
}
