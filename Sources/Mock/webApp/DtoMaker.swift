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
    
    static func makeDataChangeDto(_ object: DataChangeDto.ObjectType, _ change: DataChangeDto.ChangeType, _ id: Int32?) -> DataChangeDto {
        let dto = DataChangeDto()
        dto.changeType = change
        dto.objectType = object
        dto.objectId = id
        dto.id = DtoMaker.getUniqueID()
        return dto
    }
    
    static func makeItem(storage: DataStorage) -> ItemDto? {
        
        guard let itemType = (storage.itemTypes.filter{ $0.code == "STB" }.first) else { return nil }
        
        let dto = ItemDto()
        dto.id = DtoMaker.getUniqueID()
        dto.amount = 1
        dto.editTab = nil
        dto.itemTypeId = itemType.id
        dto.itemValues = []
        dto.name = itemType.typeName
        dto.statusId = 6
        dto.transitionValues = []
        
        let macAttributeType = itemType.itemAttributes?.first
        let macAttribute = InventoryItemValueDto()
        macAttribute.attributeTypeId = macAttributeType?.id
        macAttribute.name = macAttributeType?.name
        let macValue = ItemValueDto()
        macValue.type = "STRING"
        macValue.stringValue = DtoMaker.randomMACAddress()
        macAttribute.value = macValue
        dto.itemValues?.append(macAttribute)
        return dto
    }
    
    private static var internalCounter: Int32 = 1000
    static func getUniqueID() -> Int32 {
        DtoMaker.internalCounter = DtoMaker.internalCounter + 1
        return DtoMaker.internalCounter
    }
    
    static func currentYear() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        return format.string(from: date)
    }
    
    func randomString(length: Int) -> String {
      let letters = "ABCDEF0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    private static func randomMACAddress() -> String {
        let letters = "ABCDEF0123456789"
        var macAddress = ""
        (0...5).forEach { index in
            if index > 0 { macAddress.append(":") }
            (0...1).forEach { _ in
                if let x = letters.randomElement() {
                    macAddress.append(x)
                }
            }
        }
        return macAddress
    }
}
