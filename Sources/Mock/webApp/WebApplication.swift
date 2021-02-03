//
//  WebApplication.swift
//  
//
//  Created by Tomasz Kucharski on 23/12/2020.
//

import Foundation

let resourcesPath = FileManager.default.currentDirectoryPath + String.pathSeparator + "Resources" + String.pathSeparator

class WebApplication {

    let storage = DataStorage()
    
    init(_ server: HttpServer) {

        server["/"] = { request in
            return .notFound
        }
        
        server.GET["/fsm-mobile/tenant/default"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            let tenantDto = TenantDto()
            tenantDto.key = "Telco"
            return tenantDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/apps/latest"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let apiVersionDto = ApiVersionDto()
            apiVersionDto.status = .CURRENT
            apiVersionDto.version = contentType.replacingOccurrences(of: "application/vnd.comarch.fsm-", with: "").replacingOccurrences(of: "+json", with: "")
            
            let latestDto = LatestDto()
            latestDto.version = "master-snapshot"
            latestDto.supportedApiVersions = [apiVersionDto]
            return latestDto.asValidRsponse(contentType: contentType)
        }
        
        // generating html form and redirect [handled by browser]
        server.GET["/auth/realms/:tenant/protocol/openid-connect/auth"] = { request in
            let redirectUrl = request.queryParams.filter{ $0.0 == "redirect_uri" }.map{ $0.1 }.first ?? ""
            return HttpResponse.movedTemporarily("\(redirectUrl)?code=\(UUID().uuidString)")
        }
        
        server.POST["/auth/realms/:tenant/protocol/openid-connect/token"] = { request in
            
            let contentType = request.headers["accept"] ?? "application/json"
            let dto = OAuthAccessTokenDto()
            dto.accessToken = UUID().uuidString
            dto.expiresIn = 6000
            dto.refreshToken = UUID().uuidString
            dto.refreshExpiresIn = 6000
            return dto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/users/me"] = { request in
            
            let contentType = request.headers["accept"] ?? "application/json"
            
            guard let userDto = (self.storage.users.filter{ $0.id == 1 }.first) else {
                return .internalServerError
            }
            return userDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/locale/translations/:lang"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let translationsDto = TranslationsDto()
            translationsDto.locale = request.params.first?.value ?? ""
            translationsDto.translations = [:]
            return translationsDto.asValidRsponse(contentType: contentType)
        }
        
        server.PUT["/fsm-mobile/notifications/instanceId/:identifier"] = { request in
            return .noContent
        }
        
        // MARK: features
        server.GET["/fsm-mobile/configuration/features"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let featureListDto = FeatureListDto()
            featureListDto.list = self.storage.features
            return featureListDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/workorder/types"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = WorkOrderTypeListDto()
            listDto.list = self.storage.orderTypes
            
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/attachments/types/forCreation"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = AttachmentTypeForCreationListDto()
            listDto.attachmentTypesForCreation = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/properties/complex"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = ComplexPropertyListDto()
            listDto.list = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/systemparameters"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = SystemParameterListDto()
            listDto.list = self.storage.systemParameters
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/dictionaries"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = DictionaryListDto()
            listDto.list = self.storage.dictionaries
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/note/templates"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = NoteTemplateListDto()
            listDto.noteTemplates = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/statushandlers"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = StatusHandlerListDto()
            listDto.list = self.storage.statuShandlers
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/priorities"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = PriorityListDto()
            listDto.list = self.storage.priorities
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Item types
        server.GET["/fsm-mobile/configuration/item/types"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = ItemTypeListDto()
            listDto.list = self.storage.itemTypes
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Item type classes
        server.GET["/fsm-mobile/configuration/item/types/class"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            
            let listDto = ItemTypeClassListDto()
            listDto.itemTypesClasses = self.storage.itemClasses
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Item type level
        server.GET["/fsm-mobile/configuration/item/types/level"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = ItemTypeLevelListDto()
            listDto.itemTypesLevels = self.storage.itemLevels
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/documents"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = DocumentListDto()
            listDto.list = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/items/my"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = ItemListDto()
            listDto.items = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/audits/filter"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let auditFiltersDto = AuditFiltersDto()
            auditFiltersDto.idsAndPredefinedAnswers = [:]
            auditFiltersDto.sectionNames = []
            
            return auditFiltersDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/locations/countries"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = CountryListDto()
            listDto.countries = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/realTime"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let dto = RealTimeConfigurationDto()
            dto.hoursInFuture = 2
            dto.hoursInPast = 2
            return dto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Statuses
        server.GET["/fsm-mobile/configuration/statuses"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = StatusListDto()
            listDto.list = self.storage.statuses
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: user's work status
        server.GET["/fsm-mobile/users/workStatus/config"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            let dto = UserConfigDto()
            dto.configurationMap = [:]
            
            let section = TaskTabSectionDto()
            section.sectionName = "Parameters"
            section.sequence = 1
            section.tabSectionItems = []
            section.tabSectionItems?.append(TaskBuilder.makeFormRow(1, question: "Ready for work?", type: "INPUT_BOOLEAN"))
            
            let tab = TaskTabDto()
            tab.sequence = 1
            tab.tabSections = [section]
            dto.configurationMap = [:]
            dto.configurationMap?["STARTED"] = tab
            return dto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: change user's status
        server.PUT["/fsm-mobile/users/workStatus/technicianChangeStatus"] = { request in
            return .noContent
        }
        
        // MARK: Configuration components
        server.GET["/fsm-mobile/configuration/components"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = ConfigurationComponentListDto()
            listDto.list = self.storage.components
            listDto.componentByTypeList = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Task flags
        server.GET["/fsm-mobile/configuration/task/flags"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = TaskFlagListDto()
            listDto.list = self.storage.taskFlags
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Task types
        server.GET["/fsm-mobile/configuration/task/types"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = TaskTypeListDto()
            listDto.list = self.storage.taskTypes
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Task ids
        server.GET["/fsm-mobile/tasks/my/ids"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            self.storage.addBusinessDataForToday()

            let dto = TasksIdListDto()
            dto.ids = self.storage.tasks.compactMap { $0.id }
            
            self.storage.dataChanges = self.storage.dataChanges.filter { $0.objectType != .task }
            return dto.asValidRsponse(contentType: contentType)
        }

        // MARK: Item status flow
        server.GET["/fsm-mobile/configuration/item/status/flows/*"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let inBox2Intalled = StatusTransitionDto()
            inBox2Intalled.firstStatusId = 6
            inBox2Intalled.nextStatusId = 7
            inBox2Intalled.noteRendered = false
            inBox2Intalled.noteRequired = false
            
            let stbFlow = StatusChangeConfigurationDto()
            stbFlow.objectTypeId = 1
            stbFlow.statusFlowList = [inBox2Intalled]
            
            
            let listDto = StatusChangeConfigurationListDto()
            listDto.list = [stbFlow]
            return listDto.asValidRsponse(contentType: contentType)
        }

        // MARK: Task status flow
        server.GET["/fsm-mobile/configuration/task/status/flows/:ids"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = StatusChangeConfigurationListDto()
            listDto.list = self.storage.statusFlow
            return listDto.asValidRsponse(contentType: contentType)
        }
        // MARK: Tasks
        server.GET["/fsm-mobile/tasks/*"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"

            self.storage.addBusinessDataForToday()
            
            let segments = request.path.split("/")
            let idString = segments[2]
            let ids = idString.split(",")
            
            let taskListDto = TaskListDto()
            taskListDto.list = []
            
            ids.compactMap{ Int32($0) }.forEach { id in
                if let taskDto = (self.storage.tasks.filter{ $0.id == id }.first) {
                    taskListDto.list?.append(taskDto)
                }
            }
            
            return taskListDto.asValidRsponse(contentType: contentType)
        }

        // MARK: Task's complexes
        server.GET["/fsm-mobile/tasks/:id/complexes"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = ComplexPropertyListDto()
            listDto.list = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: start task's track record
        server.PUT["/fsm-mobile/tasks/*/startTaskTracking"] = { request in
            return .noContent
        }
        
        // MARK: end task's track record
        server.PUT["/fsm-mobile/tasks/*/endTaskTracking"] = { request in
            return .noContent
        }

        // MARK: Create and get task's announcements
        server["/fsm-mobile/tasks/:id/task-items"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let taskId = Int32(request.params[":id"] ?? "") ?? 0
            
            switch request.method {
            case "GET":
                
                let listDto = TaskItemListDto()
                listDto.taskItems = self.storage.taskItems.filter { $0.taskId == taskId }
                switch listDto.taskItems?.count ?? 0 {
                case 0:
                    return .noContent
                default:
                    return listDto.asValidRsponse(contentType: contentType)
                }
                
            case "POST":
                guard let bodyString = request.bodyString, !bodyString.isEmpty else {
                    Logger.error("Input data", "Empty request body")
                    return .badRequest(nil)
                }
                if let inputDto = try? JSONDecoder().decode(TaskItemDto.self, from: Data(bodyString.utf8)) {
                
                    let taskItemId = DtoMaker.getUniqueID()
                    inputDto.taskItemId = taskItemId
                    inputDto.taskId = taskId
                    self.storage.taskItems.append(inputDto)
                    
                    let listDto = TaskItemListDto()
                    listDto.taskItems = [inputDto]
                    return listDto.asValidRsponse(contentType: contentType)
                }
                Logger.error("Invalid input body", bodyString)
                return .badRequest(nil)
            default:
                return .notAcceptable
            }
            
        }
        // MARK: Add item to announcement
        server.POST["/fsm-mobile/tasks/*/task-items/:announcementId/item"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
        
            let announcementId = Int32(request.params[":announcementId"] ?? "") ?? 0
            guard let bodyString = request.bodyString, !bodyString.isEmpty else {
                Logger.error("Input data", "Empty request body")
                return .badRequest(nil)
            }
            if let inputDto = try? JSONDecoder().decode(ItemDto.self, from: Data(bodyString.utf8)), let announcement = (self.storage.taskItems.filter { $0.taskItemId == announcementId }.first) {
            
                let itemId = DtoMaker.getUniqueID()
                inputDto.id = itemId
                inputDto.statusId = 6
                inputDto.name = self.storage.itemTypes.filter { $0.id == inputDto.itemTypeId }.first?.typeName ?? "invalid"
                announcement.item = inputDto
                
                return announcement.asValidRsponse(contentType: contentType)
            }
            Logger.error("Invalid input body", bodyString)
            return .badRequest(nil)
        }
        
        // MARK: Delete task item
        server.DELETE["/fsm-mobile/tasks/1/task-items/:id"] = { request in
            let taksItemId = Int32(request.params[":id"] ?? "")
            self.storage.taskItems = self.storage.taskItems.filter { $0.taskItemId != taksItemId }
            return .noContent
        }
        
        // MARK: Change task status
        server.PUT["/fsm-mobile/tasks/:id/status"] = { request in

            guard let id = Int32(request.params[":id"] ?? ""), let taskDto = (self.storage.tasks.filter { $0.id == id }.first) else {
                Logger.error("Status change", "Invalid task id \(request.path)")
                return .badRequest(nil)
            }
             
            guard let bodyString = request.bodyString, !bodyString.isEmpty else {
                Logger.error("Input data", "Empty request body")
                return .badRequest(nil)
            }
             
            let inputDto = try? JSONDecoder().decode(TaskStatusChangeChainDto.self, from: Data(bodyString.utf8))
            if let statusChange = (inputDto?.taskStatusChangeChainDto?.sorted { $0.sequence ?? 0 < $1.sequence ?? 0 }.last) {
                taskDto.statusId = statusChange.statusId
                 
                let changeDto = DtoMaker.makeDataChangeDto(.task, .update, taskDto.id)
                self.storage.dataChanges.append(changeDto)

                self.storage.addBusinessDataForToday()
                return .noContent
            }
        
            return .badRequest(nil)
             
         }
        
        // MARK: Edit attachment's comment
        server.POST["/fsm-mobile/attachments/editComment"] = { request in
            
            if let inputDto = try? JSONDecoder().decode(AttachmentCommentDto.self, from: Data(request.bodyString!.utf8)) {
                for task in self.storage.tasks {
                    for attachment in task.attachmentsInfo ?? [] {
                        if attachment.id == inputDto.attachmentId {
                            attachment.comment = inputDto.comment
                        }
                    }
                }
            }
            return .noContent
        }
        
        // MARK: Detele attachment from task
        server.DELETE["/fsm-mobile/attachments/:attachmentId/delete"] = { request in
            let attachmentId = Int32(request.params[":attachmentId"] ?? "")
            for task in self.storage.tasks {
                task.attachmentsInfo = task.attachmentsInfo?.filter { $0.id != attachmentId }
            }
            return .noContent
        }
        
        // MARK: upload attachment
        server.POST["/fsm-mobile/attachments/upload"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let objectIdString = request.queryParams.filter { $0.0 == "objectId" }.first?.1
            let fileName = request.queryParams.filter { $0.0 == "fileName" }.first?.1
            
            guard let taskID = Int32(objectIdString ?? ""), let taskDto = (self.storage.tasks.filter { $0.id == taskID }.first) else {
                return .badRequest(nil)
            }
            let dto = AttachmentInfoDto()
            dto.id = DtoMaker.getUniqueID()
            dto.fileName = fileName
            dto.createDate = Date()
            dto.createUserFullName = self.storage.users.filter { $0.id == 1 }.first?.fullName
            dto.canDelete = true
            dto.attachmentType = "TASK"
            dto.size = Int32(request.body.count)
            
            taskDto.attachmentsInfo?.append(dto)
            return dto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Update attachment's properties
        server.PUT["/fsm-mobile/attachments/:attachmentID/properties"] = { request in
            return .noContent
        }
        
        // MARK: Add note to task
        server.POST["/fsm-mobile/tasks/:taskID/notes"] = { request in
            
            if let inputDto = try? JSONDecoder().decode(TaskNotesDto.self, from: Data(request.bodyString!.utf8)),
                let taskID = Int32(request.params.first?.value ?? ""), let taskDto = (self.storage.tasks.filter{ $0.id == taskID }.first) {
                inputDto.notes.forEach { note in
                    note.externalId = DtoMaker.getUniqueID()
                    note.isFullNoteContentAvailable = true
                    taskDto.notes?.append(note)
                    
                    if note.note?.lowercased() == "delete" {
                        let taskChange = DtoMaker.makeDataChangeDto(.task, .delete, taskDto.id)
                        self.storage.dataChanges.append(taskChange)
                        self.storage.tasks = self.storage.tasks.filter { $0.id != taskID }
                        
                        if let calendar = (self.storage.calendarEvents.filter { $0.taskId == taskID}.first) {
                            let calendarChange = DtoMaker.makeDataChangeDto(.calendarEvent, .delete, calendar.id)
                            self.storage.dataChanges.append(calendarChange)
                            self.storage.calendarEvents = self.storage.calendarEvents.filter { $0.id != calendar.id }
                        }
                        
                    }
                }
                
            }
            return .noContent
        }
        
        // MARK: calendar's event types
        server.GET["/fsm-mobile/configuration/calendar/eventtypes"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = CalendarEventTypeListDto()
            listDto.list = self.storage.calendarEventTypes
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: calendar
        server.GET["/fsm-mobile/calendars/*"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
                        
            self.storage.addBusinessDataForToday()

            let segments = request.path.split("/")
            let action = segments[2]
            
            switch action {
            case "my":
                let listDto = CalendarEventListDto()
                listDto.events = self.storage.calendarEvents
                self.storage.dataChanges = self.storage.dataChanges.filter { $0.objectType != .calendarEvent }
                return listDto.asValidRsponse(contentType: contentType)
            default:
                let ids = action.split(",")
                let listDto = CalendarEventListDto()
                listDto.events = []
                
                ids.compactMap{ Int32($0) }.forEach { id in
                    if let calendarDto = (self.storage.calendarEvents.filter{ $0.id == id }.first) {
                        listDto.events?.append(calendarDto)
                    }
                }
                return listDto.asValidRsponse(contentType: contentType)
            }
            
            
        }
        
        // MARK: calendar version
        server.GET["/fsm-mobile/calendars/my/version"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            return .ok(.data(UUID().uuidString.data(using: .utf8)!, contentType: contentType))
        }
        
        // MARK: create new calendar event
        server.POST["/fsm-mobile/calendars/create"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            let dto = CalendarUpdateResultDto()
            dto.id = DtoMaker.getUniqueID()
            dto.calendarVersion = UUID().uuidString
            return dto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: messages
        server.GET["/fsm-mobile/messages/*"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            self.storage.addBusinessDataForToday()
            
            let segments = request.path.split("/")
            let action = segments[2]
            switch action {
            case "my":
                self.storage.dataChanges = self.storage.dataChanges.filter { $0.objectType != .message }
                let listDto = MessageListDto()
                listDto.list = self.storage.messages
                return listDto.asValidRsponse(contentType: contentType)
            case "recipients":
                let listDto = UserListDto()
                listDto.users = self.storage.users.filter { $0.id != 1 }
                return listDto.asValidRsponse(contentType: contentType)
            default:
                let ids = action.split(",")
                let listDto = MessageListDto()
                listDto.list = []
                
                ids.compactMap{ Int32($0) }.forEach { id in
                    if let messageDto = (self.storage.messages.filter{ $0.id == id }.first) {
                        listDto.list?.append(messageDto)
                    }
                }
                return listDto.asValidRsponse(contentType: contentType)
            }
            
        }
        
        // MARK: send message
        server.POST["/fsm-mobile/messages/send"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
                
            if let messageDto = try? JSONDecoder().decode(MessageDto.self, from: Data(request.bodyString!.utf8)),
                let recipientID = Int32(request.queryParams.first?.1 ?? ""), let recipient = (self.storage.users.filter{ $0.id == recipientID }.first) {
                
                let sender = self.storage.users.filter{ $0.id == 1 }.first
                
                messageDto.id = DtoMaker.getUniqueID()
                messageDto.recipientId = recipient.id
                messageDto.recipientDisplayName = recipient.fullName
                messageDto.createDate = Date()
                messageDto.senderFullName = sender?.fullName
                messageDto.senderId = sender?.id
                messageDto.status = "DELIVERED"
                messageDto.priority = messageDto.priority ?? "LOW"
                self.storage.messages.append(messageDto)
                
                var answers: [String] = []
                answers.append("What do you mean?")
                answers.append("Leave me alone")
                answers.append("No")
                answers.append("Do not make me angry...")
                answers.append("Why are you so serious?")
                answers.append("Please explain me that")
                answers.shuffle()
                let responseMessageDto = DtoMaker.makeMessageDto(from: recipient, to: sender, msg: answers.first ?? "")
                self.storage.messages.append(responseMessageDto)
                
                let dataChange = DtoMaker.makeDataChangeDto(.message, .insert, responseMessageDto.id)
                self.storage.dataChanges.append(dataChange)
                return messageDto.asValidRsponse(contentType: contentType)
            }
            return .noContent
        }
        
        server.PUT["/fsm-mobile/messages"] = { request in
            
            if let messageListDto = try? JSONDecoder().decode(MessageListDto.self, from: Data(request.bodyString!.utf8)) {
                (messageListDto.list ?? []).forEach { dto in
                    if let status = dto.status, let message = (self.storage.messages.filter { $0.id == dto.id }.first) {
                        message.status = status
                    }
                }
            }
            
            return .noContent
        }
        
        // MARK: Report GPS position
        server.POST["/fsm-mobile/gps/position"] = { request in
            return .noContent
        }
        
        // MARK: Get data changes
        server.GET["/fsm-mobile/notifications/my/notdownloaded"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            self.storage.addBusinessDataForToday()
            
            if self.storage.dataChanges.isEmpty {
                return .noContent
            }
            
            let listDto = DataChangeListDto()
            listDto.list = self.storage.dataChanges.map { $0 }
            self.storage.dataChanges = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Log app error
        server.POST["/fsm-mobile/logs/errors"] = { request in
            return .noContent
        }
        
        // MARK: Download attachment
        server.GET["/fsm-mobile/attachments/:fileID"] = { request in
            
            //let filename = "attachment\(request.params.first?.value ?? "").jpg"
            let filename = "attachment1.jpg"
            do {
               let filePath = resourcesPath + filename
               Logger.info("Open file", filePath)
               let file = try filePath.openForReading()
               let mimeType = filePath.mimeType()
               var responseHeader: [String: String] = ["Content-Type": mimeType]

               let attr = try FileManager.default.attributesOfItem(atPath: filePath)
               if let fileSize = attr[FileAttributeKey.size] as? UInt64 {
                   responseHeader["Content-Length"] = String(fileSize)
               }

               return .raw(200, "OK", responseHeader, { writer in
                   try writer.write(file)
                   file.close()
               })
               
            } catch {
               Logger.error("Avatar problem", "\(error.localizedDescription)")
               return .notFound
            }
            
        }
        
        // MARK: Download avatar
        server.GET["/fsm-mobile/users/avatar/:id"] = { request in
            let filename = "avatar\(request.params.first?.value ?? "").jpg"
            do {
                let filePath = resourcesPath + filename
                Logger.info("Open file", filePath)
                let file = try filePath.openForReading()
                let mimeType = filePath.mimeType()
                var responseHeader: [String: String] = ["Content-Type": mimeType]

                let attr = try FileManager.default.attributesOfItem(atPath: filePath)
                if let fileSize = attr[FileAttributeKey.size] as? UInt64 {
                    responseHeader["Content-Length"] = String(fileSize)
                }

                return .raw(200, "OK", responseHeader, { writer in
                    try writer.write(file)
                    file.close()
                })
                
            } catch {
                Logger.error("Avatar problem", "\(error.localizedDescription)")
                return .notFound
            }
        }
        
        server.notFoundHandler = { request in
            Logger.error("Unhandled request", "\(request.method) `\(request.path)`")
            return .notFound
        }
        
        server.middleware.append { request in
            Logger.info("Incoming request", "\(request.method) \(request.path)")
            return nil
        }
    }
}
