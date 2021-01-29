//
//  TaskNoteDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TaskNotesDto: Codable {
    var notes: [TaskNoteDto] = []
}

class TaskNoteDto: Codable {
    
    var externalId: Int32?
    var author: String?
    var note: String?
    var creationDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_creationDate)
        }
        set(newCreationDate) {
            _creationDate = MobileApiDateTransform().transformToJSON(newCreationDate)
        }
    }
    private var _creationDate: Double?
    var isFullNoteContentAvailable: Bool?
    var contentLength: Int32?
    
    enum CodingKeys: String, CodingKey {
        case externalId = "id"
        case author
        case note
        case _creationDate = "creationDate"
        case contentLength
        case isFullNoteContentAvailable = "fullNoteContentAvailable"
    }
}
