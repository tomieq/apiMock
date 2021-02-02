//
//  DataStorage.swift
//  
//
//  Created by Tomasz Kucharski on 02/02/2021.
//

import Foundation

class DataStorage {
    
    var components: [ConfigurationComponentDto] = []
    var systemParameters: [SystemParameterDto] = []
    var tasks: [TaskDto] = []
    var calendarEvents: [CalendarEventDto] = []
    var messages: [MessageDto] = []
    var taskItems: [TaskItemDto] = []
    var dataChanges: [DataChangeDto] = []
    var orderTypes: [WorkOrderTypeDto] = []
    var taskTypes: [TaskTypeDto] = []
    var dictionaries: [DictionaryDto] = []
    var itemTypes: [ItemTypeDto] = []
    var itemClasses: [ItemTypeClassDto] = []
    var itemLevels: [ItemTypeLevelDto] = []
    var statuses: [StatusDto] = []
    var statusFlow: [StatusChangeConfigurationDto] = []
    var statuShandlers: [StatusHandlerDto] = []
    var calendarEventTypes: [CalendarEventTypeDto] = []
    var taskFlags: [TaskFlagDto] = []
    var users: [UserDto] = []
    
    init() {
        self.initComponents()
        self.initSystemParameters()
        self.initOrderTypes()
        self.initTaskTypes()
        self.initDictionaries()
        self.initItemTypes()
        self.initItemClasses()
        self.initItemLevels()
        self.initStatuses()
        self.initStatusFlow()
        self.initStatusHandlers()
        self.initCalendarEventTypes()
        self.initTaskFlags()
        self.initUsers()
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
        
        let messagesModule = ConfigurationComponentDto()
        messagesModule.code = .messages
        messagesModule.type = .module
        messagesModule.sequence = 3
        
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
        
        self.components = [tasksModule, calendarModule, messagesModule, absenceModule, addAnnouncementButton, addItemButton, itemChangeStatusButton]
    }
    
    private func initSystemParameters() {
        let syncTime = SystemParameterDto()
        syncTime.id = WebApplication.getUniqueID()
        syncTime.name = UUID().uuidString
        syncTime.code = "MOBILE_SYNCHRONIZATION_INTERVAL"
        syncTime.type = "NUMBER_VALUE"
        syncTime.intValue = 60
        
        let sessionTime = SystemParameterDto()
        sessionTime.name = UUID().uuidString
        sessionTime.id = WebApplication.getUniqueID()
        sessionTime.code = "MOBILE_SESSION_TIME_IN_MINUTES"
        sessionTime.type = "NUMBER_VALUE"
        sessionTime.intValue = 60
        
        let calendarBack = SystemParameterDto()
        calendarBack.name = UUID().uuidString
        calendarBack.id = WebApplication.getUniqueID()
        calendarBack.code = "NUMBER_OF_DAYS_IN_PAST_FOR_MOBILE_CALENDAR"
        calendarBack.type = "NUMBER_VALUE"
        calendarBack.intValue = 2
        
        let calendarForward = SystemParameterDto()
        calendarForward.name = UUID().uuidString
        calendarForward.id = WebApplication.getUniqueID()
        calendarForward.code = "NUMBER_OF_DAYS_IN_FUTURE_FOR_MOBILE_CALENDAR"
        calendarForward.type = "NUMBER_VALUE"
        calendarForward.intValue = 7

        self.systemParameters = [syncTime, sessionTime, calendarBack, calendarForward]
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
        red.id = WebApplication.getUniqueID()
        red.entryId = red.id
        red.value = "red"
        
        let blue = DictionaryDto()
        blue.code = "BLUE"
        blue.dictionaryName = "COLORS"
        blue.id = WebApplication.getUniqueID()
        blue.entryId = blue.id
        blue.value = "blue"
        
        let green = DictionaryDto()
        green.code = "GREEN"
        green.dictionaryName = "COLORS"
        green.id = WebApplication.getUniqueID()
        green.entryId = green.id
        green.value = "green"
        
        let lightBlue = DictionaryDto()
        lightBlue.code = "LIGHT_BLUE"
        lightBlue.dictionaryName = "BLUE_COLORS"
        lightBlue.id = WebApplication.getUniqueID()
        lightBlue.entryId = lightBlue.id
        lightBlue.value = "light blue"
        lightBlue.parentIds = [blue.entryId!]
        
        let darkBlue = DictionaryDto()
        darkBlue.code = "DARK_BLUE"
        darkBlue.dictionaryName = "BLUE_COLORS"
        darkBlue.id = WebApplication.getUniqueID()
        darkBlue.entryId = darkBlue.id
        darkBlue.value = "dark blue"
        darkBlue.parentIds = [blue.entryId!]
        
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
    
    private func initStatusHandlers() {
        
        let closedInstallation = StatusHandlerDto()
        closedInstallation.code = "CLOSE"
        closedInstallation.flowId = 1
        closedInstallation.id = WebApplication.getUniqueID()
        closedInstallation.statusId = 4
        
        let onSiteInstallation = StatusHandlerDto()
        onSiteInstallation.code = "ON_SITE"
        onSiteInstallation.flowId = 1
        onSiteInstallation.id = WebApplication.getUniqueID()
        onSiteInstallation.statusId = 3
        
        let closedMaintenance = StatusHandlerDto()
        closedMaintenance.code = "CLOSE"
        closedMaintenance.flowId = 1
        closedMaintenance.id = WebApplication.getUniqueID()
        closedMaintenance.statusId = 4
        
        let onSiteMaintenance = StatusHandlerDto()
        onSiteMaintenance.code = "ON_SITE"
        onSiteMaintenance.flowId = 2
        onSiteMaintenance.id = WebApplication.getUniqueID()
        onSiteMaintenance.statusId = 3
        
        self.statuShandlers = [closedInstallation, onSiteInstallation, closedMaintenance, onSiteMaintenance]
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
    
    private func initUsers() {

        let user1 = UserDto()
        user1.id = 1
        user1.firstName = "Hans"
        user1.fullName = "Hans Klotz"
        user1.hasAvatar = true
        user1.login = "kloc"
        user1.resourceId = 90
        user1.roleCode = "TECHNICIAN"
        user1.roleName = "Tecnician"
        user1.timeZone = "Europe/Warsaw"
        user1.otpEnabled = false
        
        let user5 = UserDto()
        user5.id = 5
        user5.firstName = "Antonne"
        user5.fullName = "Antonne Killesto"
        user5.hasAvatar = true
        user5.login = "antonne"
        user5.resourceId = 5
        user5.roleCode = "TECHNICIAN"
        user5.roleName = "Technician"
        user5.timeZone = "Europe/Warsaw"
        user5.otpEnabled = false
        
        let user9 = UserDto()
        user9.id = 9
        user9.firstName = "Stefano"
        user9.fullName = "Stefano Barracuda"
        user9.hasAvatar = true
        user9.login = "stefano"
        user9.resourceId = 9
        user9.roleCode = "TECHNICIAN"
        user9.roleName = "Technician"
        user9.timeZone = "Europe/Warsaw"
        user9.otpEnabled = false
        
        let user18 = UserDto()
        user18.id = 18
        user18.firstName = "Mirosław"
        user18.fullName = "Mirosław Cebula"
        user18.hasAvatar = true
        user18.login = "miroslaw"
        user18.resourceId = 18
        user18.roleCode = "TECHNICIAN"
        user18.roleName = "Technician"
        user18.timeZone = "Europe/Warsaw"
        user18.otpEnabled = false
        
        let user19 = UserDto()
        user19.id = 19
        user19.firstName = "Stefan"
        user19.fullName = "Stefan Rotthaus"
        user19.hasAvatar = true
        user19.login = "stefan"
        user19.resourceId = 19
        user19.roleCode = "TECHNICIAN"
        user19.roleName = "Technician"
        user19.timeZone = "Europe/Warsaw"
        user19.otpEnabled = false
        
        let user25 = UserDto()
        user25.id = 25
        user25.firstName = "Mike"
        user25.fullName = "Mike Sweeter"
        user25.hasAvatar = true
        user25.login = "mike"
        user25.resourceId = 25
        user25.roleCode = "TECHNICIAN"
        user25.roleName = "Technician"
        user25.timeZone = "Europe/Warsaw"
        user25.otpEnabled = false
        
        self.users = [user1, user5, user9, user18, user19, user25]
    }
    
    func addBusinessDataForToday() {
        
        let todayCalendarEvents = self.calendarEvents.filter { $0.timeRange?.dateFrom ?? Date() > Date.startOfDay() && $0.timeRange?.dateFrom ?? Date() < Date.endOfDay() }
        
        let todayOpenTasks = self.tasks.filter{ $0.scheduledRealizationTime?.dateFrom ?? Date() > Date.startOfDay() && $0.scheduledRealizationTime?.dateFrom ?? Date() < Date.endOfDay() }.filter {  ![4, 5].contains($0.statusId)  }
        
        switch todayCalendarEvents.count {
        case 0:
            let workingTime = CalendarEventDto()
            workingTime.id = WebApplication.getUniqueID()
            workingTime.eventTypeId = 1
            workingTime.setRange(from: Date().dateWithTime(hour: 8, minute: 00), to: Date().dateWithTime(hour: 16, minute: 30))
            self.calendarEvents.append(workingTime)
        default:
            break
        }
        
        switch todayOpenTasks.count {
        case ...2:
            let date = todayOpenTasks.sorted { $0.scheduledRealizationTime?.dateFrom ?? Date() < $1.scheduledRealizationTime?.dateFrom ?? Date() }.last?.scheduledRealizationTime?.dateTo ?? Date().dateWithTime(hour: 8, minute: 00)
            for index in 0...(2 - todayOpenTasks.count) {
                let taskID = WebApplication.getUniqueID()
                let taskDto = TaskBuilder.makeTaskDto(id: taskID)
                taskDto.schedule(from: date?.dateAdding(minuteCount: index * 15), to: date?.dateAdding(minuteCount: 15 + index * 15))
                self.tasks.append(taskDto)
                
                let dataChange = DataChangeDto()
                dataChange.changeType = .insert
                dataChange.objectType = .task
                dataChange.objectId = taskID
                dataChange.id = WebApplication.getUniqueID()
                self.dataChanges.append(dataChange)
            }
        default:
            break
        }
        
        if self.messages.isEmpty {

            let recipient = self.users.filter { $0.id == 1 }.first
            let sender = self.users.filter { $0.id == 18 }.first

            let messageDto = MessageDto()
            messageDto.id = WebApplication.getUniqueID()
            messageDto.recipientId = recipient?.id
            messageDto.recipientDisplayName = recipient?.fullName
            messageDto.createDate = Date()
            messageDto.senderFullName = sender?.fullName
            messageDto.senderId = sender?.id
            messageDto.status = "DELIVERED"
            messageDto.content = "Please do not be late for work again..."
            messageDto.priority = "LOW"
            self.messages.append(messageDto)
        }
    }
}
