//
//  TaskStatusChangeDto.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation


class TaskStatusChangeChainDto: Codable {
    var taskStatusChangeChainDto: [TaskStatusChangeDto]?
}


class TaskStatusChangeDto: Codable {
    var sequence: Int32?
    var currentStatusId: Int32?
    var statusId: Int32?
    var changeStatusDate: Date? {
        get {
            return MobileApiDateTransform().transformFromJSON(_changeStatusDate)
        }
        set(newChangeStatusDate) {
            _changeStatusDate = MobileApiDateTransform().transformToJSON(newChangeStatusDate)
        }
    }
    private var _changeStatusDate: Double?
    var longitude: Double?
    var latitude: Double?
    var accuracy: Double?
    var additionalData: AdditionalDataDto?
    // real dates
    var realJourneyTime: TaskRealTimeDatesInfoDto?
    var realRealizationStartTime: TaskRealTimeDatesInfoDto?
    var realRealizationFinishTime: TaskRealTimeDatesInfoDto?
    var liveAdShouldBeStarted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case sequence
        case currentStatusId
        case statusId
        case _changeStatusDate = "changeStatusDate"
        case longitude
        case latitude
        case accuracy
        case additionalData
        case realJourneyTime
        case realRealizationStartTime
        case realRealizationFinishTime
        case liveAdShouldBeStarted
    }
}

