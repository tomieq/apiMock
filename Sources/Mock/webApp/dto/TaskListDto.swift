//
//  TaskListDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class TaskListDto: Codable {

    var list: [TaskDto]?
    enum CodingKeys: String, CodingKey {
        case list = "tasks"
    }
}
