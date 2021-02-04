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
    var features: [FeatureDto] = []
    var tasks: [TaskDto] = []
    var calendarEvents: [CalendarEventDto] = []
    var messages: [MessageDto] = []
    var warehouseItems: [ItemDto] = []
    var taskItems: [TaskItemDto] = []
    var dataChanges: [DataChangeDto] = []
    var transfers: [TransferDto] = []
    
    var orderTypes: [WorkOrderTypeDto] = []
    var taskTypes: [TaskTypeDto] = []
    var dictionaries: [DictionaryDto] = []
    var itemTypes: [ItemTypeDto] = []
    var itemClasses: [ItemTypeClassDto] = []
    var itemLevels: [ItemTypeLevelDto] = []
    var statuses: [StatusDto] = []
    var taskStatusFlow: [StatusChangeConfigurationDto] = []
    var transferStatusFlow: [StatusChangeConfigurationDto] = []
    var statuShandlers: [StatusHandlerDto] = []
    var calendarEventTypes: [CalendarEventTypeDto] = []
    var taskFlags: [TaskFlagDto] = []
    var priorities: [PriorityDto] = []
    var users: [UserDto] = []
    var warehouses: [WarehouseDto] = []
    
    init() {
        self.initComponents()
        self.initSystemParameters()
        self.initFeatures()
        self.initOrderTypes()
        self.initTaskTypes()
        self.initDictionaries()
        self.initItemTypes()
        self.initItemClasses()
        self.initItemLevels()
        self.initStatuses()
        self.initTaskStatusFlow()
        self.initTransferStatusFlow()
        self.initStatusHandlers()
        self.initCalendarEventTypes()
        self.initTaskFlags()
        self.initPriorities()
        self.initUsers()
        self.initWarehouses()
    }
    
    private func initComponents() {
        
        self.components = []
        
        let tasksModule = ConfigurationComponentDto()
        tasksModule.code = .tasks
        tasksModule.type = .module
        tasksModule.sequence = 1
        self.components.append(tasksModule)
        
        let calendarModule = ConfigurationComponentDto()
        calendarModule.code = .calendar
        calendarModule.type = .module
        calendarModule.sequence = 2
        self.components.append(calendarModule)
        
        let messagesModule = ConfigurationComponentDto()
        messagesModule.code = .messages
        messagesModule.type = .module
        messagesModule.sequence = 3
        self.components.append(messagesModule)
        
        let ossModule = ConfigurationComponentDto()
        ossModule.code = .inventoryMock
        ossModule.type = .module
        ossModule.sequence = 4
        self.components.append(ossModule)
        
        let warehouseModule = ConfigurationComponentDto()
        warehouseModule.code = .warehouse
        warehouseModule.type = .module
        warehouseModule.sequence = 5
        self.components.append(warehouseModule)
        
        let transfersModule = ConfigurationComponentDto()
        transfersModule.code = .transfers
        transfersModule.type = .module
        transfersModule.sequence = 6
        self.components.append(transfersModule)
        
        let newTaskModule = ConfigurationComponentDto()
        newTaskModule.code = .newTask
        newTaskModule.type = .module
        newTaskModule.sequence = 0
        self.components.append(newTaskModule)
        
        let absenceModule = ConfigurationComponentDto()
        absenceModule.code = .absence
        absenceModule.type = .module
        absenceModule.sequence = 0
        self.components.append(absenceModule)
        
        let addAnnouncementButton = ConfigurationComponentDto()
        addAnnouncementButton.code = .addAnnouncementButton
        addAnnouncementButton.type = .button
        addAnnouncementButton.sequence = 0
        self.components.append(addAnnouncementButton)
        
        let addItemButton = ConfigurationComponentDto()
        addItemButton.code = .addItemButton
        addItemButton.type = .button
        addItemButton.sequence = 0
        self.components.append(addItemButton)
        
        let addPictureButton = ConfigurationComponentDto()
        addPictureButton.code = .addPictureFromGalleryButton
        addPictureButton.type = .button
        addPictureButton.sequence = 0
        self.components.append(addPictureButton)
        
        let itemChangeStatusButton = ConfigurationComponentDto()
        itemChangeStatusButton.code = .changeItemStatusButton
        itemChangeStatusButton.type = .button
        itemChangeStatusButton.sequence = 0
        self.components.append(itemChangeStatusButton)
        
        let chooseItemButton = ConfigurationComponentDto()
        chooseItemButton.code = .chooseItemButton
        chooseItemButton.type = .button
        chooseItemButton.sequence = 0
        self.components.append(chooseItemButton)
        
        

    }
    
    private func initSystemParameters() {
        
        self.systemParameters = []
        
        let syncTime = SystemParameterDto()
        syncTime.id = DtoMaker.getUniqueID()
        syncTime.name = UUID().uuidString
        syncTime.code = "MOBILE_SYNCHRONIZATION_INTERVAL"
        syncTime.type = "NUMBER_VALUE"
        syncTime.intValue = 60
        self.systemParameters.append(syncTime)
        
        let sessionTime = SystemParameterDto()
        sessionTime.name = UUID().uuidString
        sessionTime.id = DtoMaker.getUniqueID()
        sessionTime.code = "MOBILE_SESSION_TIME_IN_MINUTES"
        sessionTime.type = "NUMBER_VALUE"
        sessionTime.intValue = 60
        self.systemParameters.append(sessionTime)
        
        let calendarBack = SystemParameterDto()
        calendarBack.name = UUID().uuidString
        calendarBack.id = DtoMaker.getUniqueID()
        calendarBack.code = "NUMBER_OF_DAYS_IN_PAST_FOR_MOBILE_CALENDAR"
        calendarBack.type = "NUMBER_VALUE"
        calendarBack.intValue = 2
        self.systemParameters.append(calendarBack)

        let calendarForward = SystemParameterDto()
        calendarForward.name = UUID().uuidString
        calendarForward.id = DtoMaker.getUniqueID()
        calendarForward.code = "NUMBER_OF_DAYS_IN_FUTURE_FOR_MOBILE_CALENDAR"
        calendarForward.type = "NUMBER_VALUE"
        calendarForward.intValue = 7
        self.systemParameters.append(calendarForward)
        
        let maxAttachmentSize = SystemParameterDto()
        maxAttachmentSize.name = UUID().uuidString
        maxAttachmentSize.id = DtoMaker.getUniqueID()
        maxAttachmentSize.code = "MAX_ATTACHMENT_SIZE"
        maxAttachmentSize.type = "NUMBER_VALUE"
        maxAttachmentSize.intValue = 1024 * 1024 * 3
        self.systemParameters.append(maxAttachmentSize)
        
        let maxAttachmentWidth = SystemParameterDto()
        maxAttachmentWidth.name = UUID().uuidString
        maxAttachmentWidth.id = DtoMaker.getUniqueID()
        maxAttachmentWidth.code = "MAX_PHOTO_RESOLUTION_WIDTH"
        maxAttachmentWidth.type = "NUMBER_VALUE"
        maxAttachmentWidth.intValue = 4200
        self.systemParameters.append(maxAttachmentWidth)
        
        let maxAttachmentHeight = SystemParameterDto()
        maxAttachmentHeight.name = UUID().uuidString
        maxAttachmentHeight.id = DtoMaker.getUniqueID()
        maxAttachmentHeight.code = "MAX_PHOTO_RESOLUTION_HEIGHT"
        maxAttachmentHeight.type = "NUMBER_VALUE"
        maxAttachmentHeight.intValue = 3200
        self.systemParameters.append(maxAttachmentHeight)
    }
    
    private func initFeatures() {
        self.features = []
        
        let disableUINotifications = FeatureDto()
        disableUINotifications.code = "UI_NOTIFICATIONS_DISABLED"
        disableUINotifications.enabled = false
        self.features.append(disableUINotifications)
        
        let showOrderAttachments = FeatureDto()
        showOrderAttachments.code = "SHOW_ORDER_ATTACHMENTS_ON_TASK_DETAILS"
        showOrderAttachments.enabled = false
        self.features.append(showOrderAttachments)
        
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
        red.id = DtoMaker.getUniqueID()
        red.entryId = red.id
        red.value = "red"
        
        let blue = DictionaryDto()
        blue.code = "BLUE"
        blue.dictionaryName = "COLORS"
        blue.id = DtoMaker.getUniqueID()
        blue.entryId = blue.id
        blue.value = "blue"
        
        let green = DictionaryDto()
        green.code = "GREEN"
        green.dictionaryName = "COLORS"
        green.id = DtoMaker.getUniqueID()
        green.entryId = green.id
        green.value = "green"
        
        let lightBlue = DictionaryDto()
        lightBlue.code = "LIGHT_BLUE"
        lightBlue.dictionaryName = "BLUE_COLORS"
        lightBlue.id = DtoMaker.getUniqueID()
        lightBlue.entryId = lightBlue.id
        lightBlue.value = "light blue"
        lightBlue.parentIds = [blue.entryId!]
        
        let darkBlue = DictionaryDto()
        darkBlue.code = "DARK_BLUE"
        darkBlue.dictionaryName = "BLUE_COLORS"
        darkBlue.id = DtoMaker.getUniqueID()
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
        
        let macNumber = ItemTypeAttributeDto()
        macNumber.barcodeScannable = true
        macNumber.code = "MAC"
        macNumber.id = DtoMaker.getUniqueID()
        macNumber.name = "MAC"
        macNumber.required = true
        macNumber.sequence = 1
        macNumber.showOnList = true
        macNumber.type = "STRING"
        
        stb.itemAttributes?.append(macNumber)
        
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
        
        [30, 100, 150, 300, 500].forEach { speed in
            let internet = ItemTypeDto()
            internet.id = DtoMaker.getUniqueID()
            internet.canBeCreatedAsAnnouncement = true
            internet.code = "INTERNET\(speed)"
            internet.countable = false
            internet.itemClass = "INSTALLED_SERVICES"
            internet.serializable = false
            internet.levelId = 1
            internet.typeName = "Internet \(speed)Mb/s"
            internet.itemAttributes = []
            internet.itemProposalAttributes = []
            self.itemTypes.append(internet)
        }

        
        
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
        closed.name = "Closed"
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
        
        
        let new = StatusDto()
        new.id = 7
        new.code = "NEW"
        new.name = "New"
        new.workRelated = false
        new.statusFlowType = [.itemTransfer]
        let accepted = StatusDto()
        accepted.id = 8
        accepted.code = "ACCEPTED"
        accepted.name = "Accepted"
        accepted.workRelated = false
        accepted.statusFlowType = [.itemTransfer]
        
        self.statuses = [assigned, enRoute, inProgress, closed, cancelled, inBox, installed, new, accepted]
    }
    
    private func initTaskStatusFlow() {
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
        
        self.taskStatusFlow = [installationFlow, gponCheckFlow]
    }
    
    private func initTransferStatusFlow() {
        let new2EnAccepted = StatusTransitionDto()
        new2EnAccepted.firstStatusId = 7
        new2EnAccepted.nextStatusId = 8
        new2EnAccepted.noteRendered = false
        new2EnAccepted.noteRequired = false

        let normalTransferFlow = StatusChangeConfigurationDto()
        normalTransferFlow.objectTypeId = 1
        normalTransferFlow.statusFlowList = [new2EnAccepted]
        
        
        self.transferStatusFlow = [normalTransferFlow]
    }
    
    private func initStatusHandlers() {
        
        let closedInstallation = StatusHandlerDto()
        closedInstallation.code = "CLOSE"
        closedInstallation.flowId = 1
        closedInstallation.id = DtoMaker.getUniqueID()
        closedInstallation.statusId = 4
        
        let onSiteInstallation = StatusHandlerDto()
        onSiteInstallation.code = "ON_SITE"
        onSiteInstallation.flowId = 1
        onSiteInstallation.id = DtoMaker.getUniqueID()
        onSiteInstallation.statusId = 3
        
        let closedMaintenance = StatusHandlerDto()
        closedMaintenance.code = "CLOSE"
        closedMaintenance.flowId = 1
        closedMaintenance.id = DtoMaker.getUniqueID()
        closedMaintenance.statusId = 4
        
        let onSiteMaintenance = StatusHandlerDto()
        onSiteMaintenance.code = "ON_SITE"
        onSiteMaintenance.flowId = 2
        onSiteMaintenance.id = DtoMaker.getUniqueID()
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

        let taskProcessing = CalendarEventTypeDto()
        taskProcessing.id = 2
        taskProcessing.canBeCreated = false
        taskProcessing.canBeEdited = false
        taskProcessing.code = "TASK"
        taskProcessing.color = "#1111EE"
        taskProcessing.name = "Task"
        taskProcessing.backgroundType = "EMPTY"
        
        self.calendarEventTypes = [workTime, taskProcessing]
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
    
    private func initPriorities() {
        
        self.priorities = []
        
        let low = PriorityDto()
        low.id = DtoMaker.getUniqueID()
        low.name = "Low"
        low.value = 0
        self.priorities.append(low)
        
        let medium = PriorityDto()
        medium.id = DtoMaker.getUniqueID()
        medium.name = "Medium"
        medium.value = 1
        self.priorities.append(medium)
        
        let hight = PriorityDto()
        hight.id = DtoMaker.getUniqueID()
        hight.name = "Hight"
        hight.value = 2
        self.priorities.append(hight)
        
        let critical = PriorityDto()
        critical.id = DtoMaker.getUniqueID()
        critical.name = "Critical"
        critical.value = 3
        self.priorities.append(critical)
        
        let bloker = PriorityDto()
        bloker.id = DtoMaker.getUniqueID()
        bloker.name = "Bloker"
        bloker.value = 4
        self.priorities.append(bloker)
        
        let disaster = PriorityDto()
        disaster.id = DtoMaker.getUniqueID()
        disaster.name = "Disaster"
        disaster.value = 5
        self.priorities.append(disaster)
        
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
    
    private func initWarehouses() {
        self.warehouses = []
    
        self.warehouses = self.users.map { user in
            let warehouse = WarehouseDto()
            warehouse.id = DtoMaker.getUniqueID()
            warehouse.name = user.fullName
            warehouse.owner = user.fullName
            warehouse.type = "USER"
            return warehouse
        }
    }
    
    
    
    func addBusinessDataForToday() {
        
        // delete data older than 5 days
        if let deleteBorderDate = Date.startOfDay().dateAdding(dayCount: -5) {
            self.calendarEvents = self.calendarEvents.filter { $0.timeRange?.dateFrom ?? Date() > deleteBorderDate }
            self.tasks = self.tasks.filter { $0.scheduledRealizationTime?.dateFrom ?? Date() > deleteBorderDate }
            self.messages = self.messages.filter { $0.createDate ?? Date() > deleteBorderDate }
            self.transfers = self.transfers.filter { $0.transferRange?.dateFrom ?? Date() > deleteBorderDate }
        }
        
        let todayCalendarEvents = self.calendarEvents.filter { $0.timeRange?.dateFrom ?? Date() > Date.startOfDay() && $0.timeRange?.dateFrom ?? Date() < Date.endOfDay() }
        
        let todayOpenTasks = self.tasks.filter{ $0.scheduledRealizationTime?.dateFrom ?? Date() > Date.startOfDay() && $0.scheduledRealizationTime?.dateFrom ?? Date() < Date.endOfDay() }.filter {  ![4, 5].contains($0.statusId)  }
        
        switch todayCalendarEvents.count {
        case 0:
            let workingTime = CalendarEventDto()
            workingTime.id = DtoMaker.getUniqueID()
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
                let taskID = DtoMaker.getUniqueID()
                let taskDto = TaskBuilder.makeTaskDto(id: taskID, storage: self)
                taskDto.schedule(from: date?.dateAdding(minuteCount: index * 15), to: date?.dateAdding(minuteCount: 15 + index * 15))
                self.tasks.append(taskDto)
                
                let taskChange = DataChangeDto()
                taskChange.changeType = .insert
                taskChange.objectType = .task
                taskChange.objectId = taskID
                taskChange.id = DtoMaker.getUniqueID()
                self.dataChanges.append(taskChange)
                
                let calendarDto = CalendarEventDto()
                calendarDto.eventTypeId = 2
                calendarDto.id = DtoMaker.getUniqueID()
                calendarDto.taskBusinessKey = taskDto.bussinesKey
                calendarDto.priorityId = taskDto.priorityId
                calendarDto.taskId = taskDto.id
                calendarDto.taskTypeId = taskDto.typeId
                calendarDto.taskTypeName = self.taskTypes.filter { $0.id == taskDto.typeId }.first?.name
                calendarDto.orderTypeName = self.orderTypes.filter { $0.id == taskDto.workOrderTypeId }.first?.name
                calendarDto.isTaskLocked = false
                calendarDto.setRange(from: taskDto.scheduledRealizationTime?.dateFrom, to: taskDto.scheduledRealizationTime?.dateTo)
                self.calendarEvents.append(calendarDto)
                
                let calendarChange = DataChangeDto()
                calendarChange.changeType = .insert
                calendarChange.objectType = .calendarEvent
                calendarChange.objectId = calendarDto.id
                calendarChange.id = DtoMaker.getUniqueID()
                self.dataChanges.append(calendarChange)
            }
        default:
            break
        }
        
        if self.messages.isEmpty {

            let recipient = self.users.filter { $0.id == 1 }.first
            let sender = self.users.filter { $0.id == 18 }.first
            
            let message1 = DtoMaker.makeMessageDto(from: sender, to: recipient, msg: "Hi, I have some instructions")
            message1.createDate = Date().dateAdding(minuteCount: -1)
            self.messages.append(message1)
            let message2 = DtoMaker.makeMessageDto(from: sender, to: recipient, msg: "When you close a task, you will get another. If you want to trigger DELETE-TASK, just add a note to the task with text 'delete'.")
            self.messages.append(message2)
        }
        
        let warehouseItemAmount = 3
        if self.warehouseItems.count < warehouseItemAmount {
            (1...(warehouseItemAmount-self.warehouseItems.count)).forEach { _ in
                if let itemDto = DtoMaker.makeItem(storage: self) {
                    self.warehouseItems.append(itemDto)
                    self.dataChanges.append(DtoMaker.makeDataChangeDto(.item, .insert, itemDto.id))
                }
            }
        }
    }
}
