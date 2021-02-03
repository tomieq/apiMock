//
//  DtoMaker.swift
//  
//
//  Created by Tomasz Kucharski on 03/02/2021.
//

import Foundation

class DtoMaker {
    static func makeMessageDto(from: UserDto?, to: UserDto?, msg: String) -> MessageDto {
        let messageDto = MessageDto()
        messageDto.id = DtoMaker.getUniqueID()
        messageDto.recipientId = to?.id
        messageDto.recipientDisplayName = to?.fullName
        messageDto.createDate = Date()
        messageDto.senderFullName = from?.fullName
        messageDto.senderId = from?.id
        messageDto.status = "DELIVERED"
        messageDto.content = msg
        messageDto.priority = "LOW"
        return messageDto
    }
    
    private static var internalCounter: Int32 = 1000
    static func getUniqueID() -> Int32 {
        DtoMaker.internalCounter = DtoMaker.internalCounter + 1
        return DtoMaker.internalCounter
    }
}
