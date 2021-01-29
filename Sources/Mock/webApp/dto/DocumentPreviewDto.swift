//
//  DocumentPreviewDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class DocumentListDto: Codable {
    
    var list: [DocumentPreviewDto]?
    
    enum CodingKeys: String, CodingKey {
        case list = "documentPreviewDtoList"
    }
}

enum DocumentConfigTypeCode: String, Codable {
    case order = "ORDER"
    case task = "TASK"
    case item = "ITEM"
}

enum DocumentTypeCode: String, Codable {
    case file = "FILE"
    case link = "LINK"
    case unknown = "UNKNOWN"
}

class DocumentPreviewDto: Codable {
    
    var id: Int32?
    var name: String?
    var mimeType: String?
    var link: String?
    var documentType: DocumentTypeCode?
    var itemTypeIds: [Int32]?
    var taskTypeIds: [Int32]?
    var workOrderTypeIds: [Int32]?
    
}
