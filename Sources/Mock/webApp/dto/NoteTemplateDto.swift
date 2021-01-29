//
//  NoteTemplateDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class NoteTemplateListDto: Codable {
    var noteTemplates: [NoteTemplateDto]?
}

class NoteTemplateDto: Codable {
    var id: Int32?
    var name: String?
    var text: String?
    var taskTypeIds: [Int32]?
}
