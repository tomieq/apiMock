//
//  File.swift
//  
//
//  Created by Tomasz Kucharski on 14/07/2021.
//

import Foundation

class TaskReportingUserListDto: Codable {
    var taskReportingUsers: [TaskReportingUserDto]?
}

class TaskReportingUserDto: Codable {
    var fullName: String?
    var phoneNumber: String?
}
