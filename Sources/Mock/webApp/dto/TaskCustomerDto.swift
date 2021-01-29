//
//  TaskCustomerDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class TaskCustomerDto: Codable {
    
    var id: Int32?
    var externalId: String?
    var businessName: String?
    var displayName: String?
    var homePhoneNumber: String?
    var cellPhoneNumber: String?
    var workPhoneNumber: String?
    var type: String?
    var locations: [LocationDto]?
    
}
