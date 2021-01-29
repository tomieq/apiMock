//
//  AdditionalTabDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class AdditionalTabDto: Codable {
    var fromStatusId: Int32?
    var toStatusId: Int32?
    var tab: TaskTabDto?
}
