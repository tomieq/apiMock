//
//  AttachmentInfoDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class AttachmentInfoDto: Codable {
    var id: Int32?
    var fileName: String?
    var size: Int32?
    var createDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_createDate)
        }
        set(newCreateDate) {
            _createDate = MobileApiDateTransform().transformToJSON(newCreateDate)
        }
    }
    private var _createDate: Double?
    var createUserFullName: String?
    var attachmentType: String?
    var canDelete: Bool?
    var comment: String?
    var tabs: [TaskTabDto]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fileName
        case size
        case _createDate = "createDate"
        case createUserFullName
        case attachmentType
        case canDelete
        case comment
        case tabs
    }
}
