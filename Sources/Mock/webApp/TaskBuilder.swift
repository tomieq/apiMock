//
//  TaskBuilder.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TaskBuilder {
    static func makeTaskDto(id: Int32, storage: DataStorage) -> TaskDto {
        
        var priorityIDs = storage.priorities.compactMap { $0.id }
        priorityIDs.shuffle()
        
        let taskDto = TaskDto()
        taskDto.id = id
        taskDto.bussinesKey = "T/\(id)/\(DtoMaker.currentYear())"
        taskDto.statusId = 1
        taskDto.typeId = 1
        taskDto.workOrderId = 1
        taskDto.workOrderTypeId = 1
        taskDto.createDate = Date()
        taskDto.dictionaryTimestamp = Date()
        taskDto.isOrphanable = false
        taskDto.priorityId = priorityIDs.first
        taskDto.slaDate = Date().dateAdding(minuteCount: 120)
        taskDto.notes = []
        
        let location = LocationDto()
        location.city = "Łódź"
        location.street = "Jaracza"
        location.buildingNo = "78"
        location.id = 1
        location.latitude = 51.759445
        location.longitude = 19.457216
        taskDto.location = location
        
        taskDto.additionalInformationMap = [:]
        taskDto.additionalInformationMap?["Technology"] = "GPON"
        
        let attachmentQuestion1 = TaskBuilder.makeFormRow(1, question: "Is antenna visible?", type: "INPUT_BOOLEAN")
        attachmentQuestion1.propertyClass = "ATTACHMENT"
        attachmentQuestion1.itemId = 1
        
        let attachmentQuestion2 = TaskBuilder.makeFormRow(2, question: "Describe picture", type: "INPUT_TEXT")
        attachmentQuestion2.propertyClass = "ATTACHMENT"
        attachmentQuestion2.itemId = 2

        let attachmentSection = TaskTabSectionDto()
        attachmentSection.sectionName = "Details"
        attachmentSection.sequence = 1
        attachmentSection.tabSectionItems = [attachmentQuestion1, attachmentQuestion2]
        let attachmentTab = TaskTabDto()
        attachmentTab.tabName = "Attributes"
        attachmentTab.type = "STATIC_DATA"
        attachmentTab.sequence = 1
        attachmentTab.tabSections = [attachmentSection]
        
        let pictureAttachment = AttachmentInfoDto()
        pictureAttachment.id = DtoMaker.getUniqueID()
        pictureAttachment.canDelete = true
        pictureAttachment.fileName = "patchpanel_connections.jpg"
        pictureAttachment.createDate = Date()
        pictureAttachment.tabs = [attachmentTab]
        pictureAttachment.attachmentType = "TASK"
        pictureAttachment.createUserFullName = "Admin"
        taskDto.attachmentsInfo = [pictureAttachment]
        
        // GENERAL TAB
        
        
        let basicSection = TaskTabSectionDto()
        basicSection.sequence = 1
        basicSection.sectionName = "Basic data"
        basicSection.tabSectionItems = []
        
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(1, question: "Address:", type: "STATIC_DATA").setStringValue(""))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(2, question: "Customer full name:", type: "STATIC_DATA").setStringValue("John Nowak"))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(3, question: "Task ID:", type: "STATIC_DATA").setStringValue(taskDto.bussinesKey))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(4, question: "Order ID:", type: "STATIC_DATA").setStringValue("WO/\(DtoMaker.getUniqueID())/\(DtoMaker.currentYear())"))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(5, question: "Technology:", type: "STATIC_DATA").setStringValue("GPON"))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(6, question: "Order type:", type: "STATIC_DATA").setStringValue(storage.orderTypes.filter { $0.id == taskDto.workOrderTypeId }.first?.name ?? ""))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(7, question: "Task type:", type: "STATIC_DATA").setStringValue(storage.taskTypes.filter { $0.id == taskDto.typeId }.first?.name ?? ""))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(8, question: "Priority:", type: "STATIC_DATA").setStringValue(storage.priorities.filter { $0.id == taskDto.priorityId }.first?.name ?? ""))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(9, question: "SLA:", type: "STATIC_DATA").setDateValue(taskDto.slaDate))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(10, question: "Status", type: "STATUS"))
        
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(11, question: "Assigned to:", type: "STATIC_DATA").setStringValue(storage.users.filter { $0.id == 1 }.first?.fullName ?? ""))
        basicSection.tabSectionItems?.append(TaskBuilder.makeFormRow(12, question: "Create date:", type: "STATIC_DATA").setDateValue(Date()))

        taskDto.tabs = []

        let generalTab = TaskTabDto()
        generalTab.sequence = 1
        generalTab.tabName = "General info"
        generalTab.tabSections = [basicSection]
        generalTab.type = "STATIC_DATA"
        taskDto.tabs?.append(generalTab)
        
        let equipmentsTab = TaskTabDto()
        equipmentsTab.sequence = 2
        equipmentsTab.tabName = "Equipments"
        equipmentsTab.tabSections = []
        equipmentsTab.type = "SERVICES_AND_EQUIPMENT"
        taskDto.tabs?.append(equipmentsTab)
        
        let attachmentsTab = TaskTabDto()
        attachmentsTab.sequence = 4
        attachmentsTab.tabName = "Attachments"
        attachmentsTab.tabSections = []
        attachmentsTab.type = "ATTACHMENTS"
        taskDto.tabs?.append(attachmentsTab)
        
        let notesTab = TaskTabDto()
        notesTab.sequence = 5
        notesTab.tabName = "Notes"
        notesTab.tabSections = []
        notesTab.type = "NOTES"
        taskDto.tabs?.append(notesTab)
        
        let trackRecordTab = TaskTabDto()
        trackRecordTab.sequence = 6
        trackRecordTab.tabName = "Track record"
        trackRecordTab.tabSections = []
        trackRecordTab.type = "TASK_TRACK_RECORD"
        taskDto.tabs?.append(trackRecordTab)
        
        let transferRequestTab = TaskTabDto()
        transferRequestTab.sequence = 7
        transferRequestTab.tabName = "Transfer requests"
        transferRequestTab.tabSections = []
        transferRequestTab.type = "TRANSFER_REQUESTS"
        taskDto.tabs?.append(transferRequestTab)
        taskDto.relatedTransferRequests = [1,100]
        
        taskDto.additionalTabs = TaskBuilder.makeProcessingTabs()
        return taskDto
    }
    
    static func makeProcessingTabs() -> [AdditionalTabDto] {
        
        var questions: [TaskTabSectionItemDto] = []
        questions.append(TaskBuilder.makeFormRow(1, question: "Is client satisfied?", type: "INPUT_BOOLEAN"))
        questions.append(TaskBuilder.makeFormRow(2, question: "What was needed to do?", type: "INPUT_TEXT"))
        questions.append(TaskBuilder.makeFormRow(3, question: "Describe actions", type: "INPUT_TEXT_AREA"))
        questions.append(TaskBuilder.makeFormRow(4, question: "Number of retries", type: "INPUT_INTEGER"))
        questions.append(TaskBuilder.makeFormRow(5, question: "Exact time of DHCP lease", type: "INPUT_DATE_WITH_TIME"))
        questions.append(TaskBuilder.makeFormRow(6, question: "Estimated break down time", type: "INPUT_DATE"))
        questions.append(TaskBuilder.makeFormRow(7, question: "Device serial number", type: "INPUT_BARCODE"))
        questions.append(TaskBuilder.makeFormRow(8, question: "Device root password", type: "INPUT_PASSWORD"))
        
        let colorRow = TaskBuilder.makeFormRow(9, question: "Color", type: "DICTIONARY_INPUT_SELECT_ONE_OF_MANY")
        colorRow.dictionaryName = "COLORS"
        questions.append(colorRow)
        
        let subColorRow = TaskBuilder.makeFormRow(10, question: "Color details", type: "DICTIONARY_INPUT_SELECT_ONE_OF_MANY")
        subColorRow.dictionaryName = "BLUE_COLORS"
        subColorRow.parentCode = colorRow.code
        questions.append(subColorRow)
        
        let sectionForClosingTask = TaskTabSectionDto()
        sectionForClosingTask.sequence = 1
        sectionForClosingTask.sectionName = "Results"
        sectionForClosingTask.tabSectionItems = questions
        
        let tabToClosed = TaskTabDto()
        tabToClosed.sequence = 1
        tabToClosed.tabName = "Results"
        tabToClosed.type = "STATIC_DATA"
        tabToClosed.tabSections = [sectionForClosingTask]
        var tabs: [AdditionalTabDto] = [AdditionalTabDto(3, 4, tabToClosed)]
        
        let customerSignatureTab = TaskTabDto()
        customerSignatureTab.sequence = 3
        customerSignatureTab.tabName = "Customer's signature"
        customerSignatureTab.type = "CUSTOMER_SIGNATURE"
        tabs.append(AdditionalTabDto(3, 4, customerSignatureTab))
        
        let technicianSignatureTab = TaskTabDto()
        technicianSignatureTab.sequence = 2
        technicianSignatureTab.tabName = "Technician's signature"
        technicianSignatureTab.type = "TECHNICIAN_SIGNATURE"
        tabs.append(AdditionalTabDto(3, 4, technicianSignatureTab))
        
        return tabs
    }
    
    static func makeFormRow(_ sequence: Int32, question: String, type: String) -> TaskTabSectionItemDto {
        let label = ItemLabelValuesPairDto()
        label.sequence = 1
        label.label = question
        label.values = []

        let questionRow = TaskTabSectionItemDto()
        questionRow.sequence = sequence
        questionRow.code = question.sha1()
        questionRow.itemViewType = type
        questionRow.propertyClass = "TASK"
        questionRow.itemLabelValuesPairList = [label]
        return questionRow
    }
    
}

extension TaskTabSectionItemDto {
    func setStringValue(_ text: String?) -> TaskTabSectionItemDto {
        
        let value = ItemValueDto()
        value.stringValue = text
        value.type = "STRING"
        self.itemLabelValuesPairList?.first?.values = [value]
        return self
    }

    func setDateValue(_ date: Date?) -> TaskTabSectionItemDto {
        
        let value = ItemValueDto()
        value.dateValue = date
        value.type = "DATE"
        self.itemLabelValuesPairList?.first?.values = [value]
        return self
    }
}
