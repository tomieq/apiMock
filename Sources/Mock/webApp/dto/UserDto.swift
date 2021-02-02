//
//  UserDto.swift
//  
//
//  Created by Tomasz Kucharski on 27/01/2021.
//

import Foundation

class UserListDto: Codable {
    
    var users: [UserDto]?
}

class UserDto: Codable {
    
    var id: Int32?
    var resourceId: Int32?
    var login: String?
    var fullName: String?
    var firstName: String?
    var roleCode: String?
    var roleName: String?
    var timeZone: String?
    var otpEnabled: Bool?
    var hasAvatar: Bool?
    var userWorkStatus: UserWorkStatusDto?
    
}
