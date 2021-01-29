//
//  TaskTabDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TaskTabDto: Codable {
    var tabName: String?
    var sequence: Int32?
    var type: String?
    var tabSections: [TaskTabSectionDto]?
    
}
