//
//  TaskDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class TaskDto: Codable {
    var id: Int32?
    var bussinesKey: String?
    var statusId: Int32?
    var typeId: Int32?
    var workOrderId: Int32?
    var workOrderTypeId: Int32?
    var additionalInformation: [String]?
    var additionalInformationMap: [String: String]?
    var scheduledRealizationTime: TimeRangeDto?
    var createDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_createDate)
        }
        set(newDate) {
            _createDate = MobileApiDateTransform().transformToJSON(newDate)
        }
    }
    private var _createDate: Double?
    var timeZone: String?
    var dictionaryTimestamp: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_dictionaryTimestamp)
        }
        set(newTimestamp) {
            _dictionaryTimestamp = MobileApiDateTransform().transformToJSON(newTimestamp)
        }
    }
    private var _dictionaryTimestamp: Double?
    var tabs: [TaskTabDto]?
    var additionalTabs: [AdditionalTabDto]?
    var notes: [TaskNoteDto]?
    var attachmentsInfo: [AttachmentInfoDto]?
    var isOrphanable: Bool?
    var flagIds: [Int32] { return _flagIds ?? [] }
    var _flagIds: [Int32]?
    var priorityId: Int32?
    var slaDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_slaDate)
        }
        set(newSlaDate) {
            _slaDate = MobileApiDateTransform().transformToJSON(newSlaDate)
        }
    }
    private var _slaDate: Double?
    var realRealizationFinishTime: TaskRealTimeDatesInfoDto?
    var location: LocationDto?
    var customer: TaskCustomerDto?
    var technologyId: Int32?
    var relatedTransferRequests: [Int32]?
    var isAudited: Bool?
    var isTaskLocked: Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case bussinesKey
        case statusId
        case typeId
        case workOrderId
        case workOrderTypeId
        case additionalInformation
        case additionalInformationMap
        case scheduledRealizationTime
        case _createDate = "createDate"
        case timeZone
        case _dictionaryTimestamp = "dictionaryTimestamp"
        case tabs
        case additionalTabs
        case notes
        case attachmentsInfo
        case isOrphanable
        case _flagIds = "flags"
        case priorityId
        case _slaDate = "slaDate"
        case realRealizationFinishTime
        case location
        case customer
        case technologyId
        case relatedTransferRequests
        case isAudited
        case isTaskLocked
    }
}
