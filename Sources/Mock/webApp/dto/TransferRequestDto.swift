//
//  TransferRequestDto.swift
//  
//
//  Created by Tomasz Kucharski on 04/02/2021.
//

import Foundation

class TransferRequestListDto: Codable {
    var transferRequestDtos: [TransferRequestDto]?
}

class TransferRequestDto: Codable {
    
    var id: Int32?
    var businessKey: String?
    var statusId: Int32?
    var typeId: Int32?
    var typeName: String?
    var createDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_createDate)
        }
        set(newCreateDate) {
            _createDate = MobileApiDateTransform().transformToJSON(newCreateDate)
        }
    }
    private var _createDate: Double?
    var finishDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_finishDate)
        }
        set(newFinishDate) {
            _finishDate = MobileApiDateTransform().transformToJSON(newFinishDate)
        }
    }
    private var _finishDate: Double?
    var createUserDisplayName: String?
    var finishUserDisplayName: String?
    var transferPositions: TransferListDto?
    var customProperties: [CustomPropertyDto]?
    var transitions: [TransferTransitionWithPropertiesDto]?
    var relations: [TransferRequestRelationDto]?

    
    enum CodingKeys: String, CodingKey {
        case id
        case businessKey
        case statusId
        case typeId
        case typeName
        case _createDate = "createDate"
        case _finishDate = "finishDate"
        case createUserDisplayName
        case finishUserDisplayName
        case transferPositions
        case customProperties
        case transitions
        case relations
    }
}

class TransferRequestRelationDto: Codable {
    
    var relationType: String?
    var businessKey: String?
    var transferStatus: String?
    var transferType: String?
}
