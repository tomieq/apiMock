//
//  AttachmentTypeForCreationListDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class AttachmentTypeForCreationListDto: Codable {
    var attachmentTypesForCreation: [AttachmentTypeForCreationDto]?
}

class AttachmentTypeForCreationDto: Codable {
    var type: String?
    var tabs: [TaskTabDto]?
}
