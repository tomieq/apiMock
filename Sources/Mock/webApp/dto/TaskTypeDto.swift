//
//  TaskTypeDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TaskTypeListDto: Codable {
    var list: [TaskTypeDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "taskTypeList"
    }
}


class TaskTypeDto: Codable {
    var id: Int32?
    var flowId: Int32?
    var name: String?
    var code: String?
    var maxAttachmentNumber: Int32?
    var color: String?
    var classCode: String?
}
