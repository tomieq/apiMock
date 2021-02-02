//
//  DataStorage.swift
//  
//
//  Created by Tomasz Kucharski on 02/02/2021.
//

import Foundation

class DataStorage {
    
    var components: [ConfigurationComponentDto] = []
    var tasks: [Int32: TaskDto] = [:]
    var taskItems: [Int32: TaskItemDto] = [:]
    var dataChanges: [DataChangeDto] = []
    var orderTypes: [WorkOrderTypeDto] = []
    var taskTypes: [TaskTypeDto] = []
    var dictionaries: [DictionaryDto] = []
    var itemTypes: [ItemTypeDto] = []
    var itemClasses: [ItemTypeClassDto] = []
    var itemLevels: [ItemTypeLevelDto] = []
    var statuses: [StatusDto] = []
    var statusFlow: [StatusChangeConfigurationDto] = []
    var calendarEventTypes: [CalendarEventTypeDto] = []
    var taskFlags: [TaskFlagDto] = []
    
    init() {
        self.initComponents()
        self.initOrderTypes()
        self.initTaskTypes()
        self.initDictionaries()
        self.initItemTypes()
        self.initItemClasses()
        self.initItemLevels()
        self.initStatuses()
        self.initStatusFlow()
        self.initCalendarEventTypes()
        self.initTaskFlags()
    }
    
    private func initComponents() {
        let tasksModule = ConfigurationComponentDto()
        tasksModule.code = .tasks
        tasksModule.type = .module
        tasksModule.sequence = 1
        
        let calendarModule = ConfigurationComponentDto()
        calendarModule.code = .calendar
        calendarModule.type = .module
        calendarModule.sequence = 2
        
        
        let absenceModule = ConfigurationComponentDto()
        absenceModule.code = .absence
        absenceModule.type = .module
        absenceModule.sequence = 0
        
        let addAnnouncementButton = ConfigurationComponentDto()
        addAnnouncementButton.code = .addAnnouncementButton
        addAnnouncementButton.type = .button
        addAnnouncementButton.sequence = 0
        
        let addItemButton = ConfigurationComponentDto()
        addItemButton.code = .addItemButton
        addItemButton.type = .button
        addItemButton.sequence = 0
        
        let itemChangeStatusButton = ConfigurationComponentDto()
        itemChangeStatusButton.code = .changeItemStatusButton
        itemChangeStatusButton.type = .button
        itemChangeStatusButton.sequence = 0
        
        self.components = [tasksModule, calendarModule, absenceModule, addAnnouncementButton, addItemButton, itemChangeStatusButton]
    }
    
    private func initOrderTypes() {
        let installation = WorkOrderTypeDto()
        installation.id = 1
        installation.name = "Installation"
        installation.code = "INSTALATION"
        
        let maintenance = WorkOrderTypeDto()
        maintenance.id = 2
        maintenance.name = "Maintenance"
        maintenance.code = "MAINTENANCE"

        self.orderTypes = [installation, maintenance]
    }
    
    private func initTaskTypes() {
        let installation = TaskTypeDto()
        installation.id = 1
        installation.classCode = "FIELS_INSTALLATION_CLASS"
        installation.code = "FIELD_INSTALLATION"
        installation.flowId = 1
        installation.maxAttachmentNumber = 100
        installation.name = "Field Installation"

        let gponCheck = TaskTypeDto()
        gponCheck.id = 2
        gponCheck.classCode = "GPON_CHECK_CLASS"
        gponCheck.code = "GPON_CHECK"
        gponCheck.flowId = 1
        gponCheck.maxAttachmentNumber = 100
        gponCheck.name = "GPON Check"
        
        self.taskTypes = [installation, gponCheck]
    }
    
    private func initDictionaries() {
        let red = DictionaryDto()
        red.code = "RED"
        red.dictionaryName = "COLORS"
        red.entryId = 1
        red.id = 1
        red.value = "red"
        
        let blue = DictionaryDto()
        blue.code = "BLUE"
        blue.dictionaryName = "COLORS"
        blue.entryId = 2
        blue.id = 2
        blue.value = "blue"
        
        let green = DictionaryDto()
        green.code = "GREEN"
        green.dictionaryName = "COLORS"
        green.entryId = 3
        green.id = 3
        green.value = "green"
        
        let lightBlue = DictionaryDto()
        lightBlue.code = "LIGHT_BLUE"
        lightBlue.dictionaryName = "BLUE_COLORS"
        lightBlue.entryId = 4
        lightBlue.id = 4
        lightBlue.value = "light blue"
        lightBlue.parentIds = [2]
        
        let darkBlue = DictionaryDto()
        darkBlue.code = "DARK_BLUE"
        darkBlue.dictionaryName = "BLUE_COLORS"
        darkBlue.entryId = 5
        darkBlue.id = 5
        darkBlue.value = "dark blue"
        darkBlue.parentIds = [2]
        
        self.dictionaries = [red, blue, green, lightBlue, darkBlue]
    }
    
    private func initItemTypes() {
        let stb = ItemTypeDto()
        stb.id = 1
        stb.canBeCreatedAsAnnouncement = true
        stb.code = "STB"
        stb.countable = false
        stb.itemClass = "EQUIPMENT"
        stb.serializable = true
        stb.levelId = 1
        stb.typeName = "STB"
        stb.itemAttributes = []
        stb.itemProposalAttributes = []
        
        let cable = ItemTypeDto()
        cable.id = 2
        cable.canBeCreatedAsAnnouncement = true
        cable.code = "RJ45"
        cable.countable = true
        cable.itemClass = "MATERIALS"
        cable.serializable = false
        cable.levelId = 1
        cable.typeName = "Ethernet cable RJ45"
        cable.itemAttributes = []
        cable.itemProposalAttributes = []
        
        self.itemTypes = [stb, cable]
    }
    
    private func initItemClasses() {
        let equipment = ItemTypeClassDto()
        equipment.id = 1
        equipment.name = "Equipments"
        equipment.canBeCreatedAsAnnouncement = true
        equipment.canBeDeleted = true
        equipment.canBeChanged = true
        equipment.code = "EQUIPMENT"
        
        let materials = ItemTypeClassDto()
        materials.id = 2
        materials.name = "Materials"
        materials.canBeCreatedAsAnnouncement = true
        materials.canBeDeleted = true
        materials.canBeChanged = true
        materials.code = "MATERIALS"
        
        let installedServices = ItemTypeClassDto()
        installedServices.id = 3
        installedServices.name = "Services"
        installedServices.canBeCreatedAsAnnouncement = false
        installedServices.canBeDeleted = false
        installedServices.canBeChanged = false
        installedServices.code = "INSTALLED_SERVICES"
        
        self.itemClasses = [equipment, materials, installedServices]
    }
    
    private func initItemLevels() {
        let level1 = ItemTypeLevelDto()
        level1.id = 1
        level1.code = "LEVEL1"
        level1.name = "Type"
        level1.isFinal = true
        
        self.itemLevels = [level1]
    }
    
    private func initStatuses() {
        let assigned = StatusDto()
        assigned.id = 1
        assigned.code = "ASSIGNED"
        assigned.name = "Assigned"
        assigned.workRelated = false
        assigned.statusFlowType = [.task]
        let enRoute = StatusDto()
        enRoute.id = 2
        enRoute.code = "EN_ROUTE"
        enRoute.name = "En route"
        enRoute.workRelated = false
        enRoute.statusFlowType = [.task]
        let inProgress = StatusDto()
        inProgress.id = 3
        inProgress.code = "IN_PROGRESS"
        inProgress.name = "In progress"
        inProgress.workRelated = false
        inProgress.statusFlowType = [.task]
        let closed = StatusDto()
        closed.id = 4
        closed.code = "CLOSED"
        closed.name = "Close"
        closed.workRelated = false
        closed.statusFlowType = [.task]
        let cancelled = StatusDto()
        cancelled.id = 5
        cancelled.code = "CANCELLED"
        cancelled.name = "Cancelled"
        cancelled.workRelated = false
        cancelled.statusFlowType = [.task]
        
        let inBox = StatusDto()
        inBox.id = 6
        inBox.code = "IN_BOX"
        inBox.name = "In box"
        inBox.workRelated = false
        inBox.statusFlowType = [.equipment]
        let installed = StatusDto()
        installed.id = 7
        installed.code = "INSTALLED"
        installed.name = "Installed"
        installed.workRelated = false
        installed.statusFlowType = [.equipment]
        
        self.statuses = [assigned, enRoute, inProgress, closed, cancelled, inBox, installed]
    }
    
    private func initStatusFlow() {
        let assigned2EnRoute = StatusTransitionDto()
        assigned2EnRoute.firstStatusId = 1
        assigned2EnRoute.nextStatusId = 2
        assigned2EnRoute.noteRendered = false
        assigned2EnRoute.noteRequired = false
        let enRoute2InProgress = StatusTransitionDto()
        enRoute2InProgress.firstStatusId = 2
        enRoute2InProgress.nextStatusId = 3
        enRoute2InProgress.noteRendered = false
        enRoute2InProgress.noteRequired = false
        let inProgress2Closed = StatusTransitionDto()
        inProgress2Closed.firstStatusId = 3
        inProgress2Closed.nextStatusId = 4
        inProgress2Closed.noteRendered = false
        inProgress2Closed.noteRequired = false
        let inProgress2Cancelled = StatusTransitionDto()
        inProgress2Cancelled.firstStatusId = 3
        inProgress2Cancelled.nextStatusId = 5
        inProgress2Cancelled.noteRendered = false
        inProgress2Cancelled.noteRequired = false

        let installationFlow = StatusChangeConfigurationDto()
        installationFlow.objectTypeId = 1
        installationFlow.statusFlowList = [assigned2EnRoute, enRoute2InProgress, inProgress2Closed, inProgress2Cancelled]
        
        let gponCheckFlow = StatusChangeConfigurationDto()
        gponCheckFlow.objectTypeId = 2
        gponCheckFlow.statusFlowList = [assigned2EnRoute, enRoute2InProgress, inProgress2Closed, inProgress2Cancelled]
        
        self.statusFlow = [installationFlow, gponCheckFlow]
    }
    
    private func initCalendarEventTypes() {
        let workTime = CalendarEventTypeDto()
        workTime.id = 1
        workTime.canBeCreated = true
        workTime.canBeEdited = true
        workTime.code = "WORK_TIME"
        workTime.color = "#11EE11"
        workTime.name = "Work time"
        workTime.backgroundType = "EMPTY"
        
        self.calendarEventTypes = [workTime]
    }
    
    private func initTaskFlags() {
        let flagInRisk = TaskFlagDto()
        flagInRisk.id = 1
        flagInRisk.code = "IN_RISK"
        flagInRisk.name = "In risk"

        let flagSLAExceeded = TaskFlagDto()
        flagSLAExceeded.id = 2
        flagSLAExceeded.code = "SLA_EXCEEDED"
        flagSLAExceeded.name = "SLA Exceeded"
        
        self.taskFlags = [flagInRisk, flagSLAExceeded]
    }
}
