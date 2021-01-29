//
//  TaskBuilder.swift
//  
//
//  Created by Tomasz Kucharski on 28/01/2021.
//

import Foundation

class TaskBuilder {
    static func makeTaskDto(id: Int32) -> TaskDto {
        let taskDto = TaskDto()
        taskDto.id = id
        taskDto.bussinesKey = "T/\(id)/\(self.currentYear())"
        taskDto.statusId = 1
        taskDto.typeId = 1
        taskDto.workOrderId = 1
        taskDto.workOrderTypeId = 1
        taskDto.createDate = Date()
        taskDto.dictionaryTimestamp = Date()
        taskDto.isOrphanable = false
        taskDto.priorityId = 1
        taskDto.slaDate = Date()
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
        
        let attachmentQuestionLabel1 = ItemLabelValuesPairDto()
        attachmentQuestionLabel1.label = "Is antenna visible?"
        attachmentQuestionLabel1.sequence = 1
        attachmentQuestionLabel1.values = []
        let attachmentQuestion1 = TaskTabSectionItemDto()
        attachmentQuestion1.code = "IS_ANTENNA_VISIBLE"
        attachmentQuestion1.itemViewType = "INPUT_BOOLEAN"
        attachmentQuestion1.propertyClass = "ATTACHMENT"
        attachmentQuestion1.itemId = 1
        attachmentQuestion1.itemLabelValuesPairList = [attachmentQuestionLabel1]
        attachmentQuestion1.sequence = 1
        let attachmentQuestionLabel2 = ItemLabelValuesPairDto()
        attachmentQuestionLabel2.label = "Describe picture"
        attachmentQuestionLabel2.sequence = 1
        attachmentQuestionLabel2.values = []
        let attachmentQuestion2 = TaskTabSectionItemDto()
        attachmentQuestion2.code = "DESCRIPTION"
        attachmentQuestion2.itemViewType = "INPUT_TEXT"
        attachmentQuestion2.propertyClass = "ATTACHMENT"
        attachmentQuestion2.itemId = 1
        attachmentQuestion2.itemLabelValuesPairList = [attachmentQuestionLabel2]
        attachmentQuestion2.sequence = 2
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
        pictureAttachment.id = 1
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
        basicSection.sectionName = "Basic"
        
        let statusRow = TaskTabSectionItemDto()
        statusRow.sequence = 5
        statusRow.itemViewType = "STATUS"
        
        let statusLabel = ItemLabelValuesPairDto()
        statusLabel.sequence = 1
        statusLabel.label = "Status"
        statusLabel.values = []
        
        statusRow.itemLabelValuesPairList = [statusLabel]
        
        basicSection.tabSectionItems = [statusRow]

        let generalTab = TaskTabDto()
        generalTab.sequence = 1
        generalTab.tabName = "General info"
        generalTab.tabSections = [basicSection]
        generalTab.type = "STATIC_DATA"
        
        let attachmentsTab = TaskTabDto()
        attachmentsTab.sequence = 4
        attachmentsTab.tabName = "Attachments"
        attachmentsTab.tabSections = []
        attachmentsTab.type = "ATTACHMENTS"
        
        let notesTab = TaskTabDto()
        notesTab.sequence = 5
        notesTab.tabName = "Notes"
        notesTab.tabSections = []
        notesTab.type = "NOTES"
        
        let equipmentsTab = TaskTabDto()
        equipmentsTab.sequence = 2
        equipmentsTab.tabName = "Equipments"
        equipmentsTab.tabSections = []
        equipmentsTab.type = "SERVICES_AND_EQUIPMENT"
        
        taskDto.tabs = [generalTab, attachmentsTab, notesTab, equipmentsTab]
        taskDto.additionalTabs = TaskBuilder.makeProcessingTabs()
        return taskDto
    }
    
    static func currentYear() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy"
        return format.string(from: date)
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
        
        let wrappedTabToClosed = AdditionalTabDto()
        wrappedTabToClosed.fromStatusId = 3
        wrappedTabToClosed.toStatusId = 4
        wrappedTabToClosed.tab = tabToClosed
        
        let tabs: [AdditionalTabDto] = [wrappedTabToClosed]
        return tabs
    }
    
    private static func makeFormRow(_ sequence: Int32, question: String, type: String) -> TaskTabSectionItemDto {
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
