//
//  TaskTabSectionDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TaskTabSectionDto: Codable {
    var sectionName: String?
    var sequence: Int32?
    var tabSectionItems: [TaskTabSectionItemDto]?

}
