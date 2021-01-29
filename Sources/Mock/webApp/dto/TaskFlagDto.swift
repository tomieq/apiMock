//
//  TaskFlagDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TaskFlagListDto: Codable {
    
    var list: [TaskFlagDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "taskFlagList"
    }
}


class TaskFlagDto: Codable {
    
    var id: Int32?
    var name: String?
    var code: String?
}
