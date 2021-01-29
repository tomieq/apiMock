//
//  WebApplication.swift
//  
//
//  Created by Tomasz Kucharski on 23/12/2020.
//

import Foundation

class WebApplication {

    private static var randomID: Int32 = 1000
    let tasks: [Int32: TaskDto]
    var taskItems: [Int32: TaskItemDto] = [:]
    var dataChanges: [DataChangeDto] = []
    
    init(_ server: HttpServer) {

        self.tasks = [ 1 : TaskBuilder.makeTaskDto(id: 1), 2 : TaskBuilder.makeTaskDto(id: 2)]
        
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
            let userDto = UserDto()
            userDto.id = 1
            userDto.firstName = "Hans"
            userDto.fullName = "Hans Klotz"
            userDto.hasAvatar = true
            userDto.login = "kloc"
            userDto.resourceId = 90
            userDto.roleCode = "TECHNICIAN"
            userDto.roleName = "Tecnician"
            userDto.timeZone = "Europe/Warsaw"
            userDto.otpEnabled = false
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
        
        server.GET["/fsm-mobile/configuration/features"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let featureListDto = FeatureListDto()
            featureListDto.list = []
            return featureListDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/workorder/types"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let installation = WorkOrderTypeDto()
            installation.id = 1
            installation.name = "Installation"
            installation.code = "INSTALATION"
            let maintenance = WorkOrderTypeDto()
            maintenance.id = 2
            maintenance.name = "Maintenance"
            maintenance.code = "MAINTENANCE"
            
            let listDto = WorkOrderTypeListDto()
            listDto.list = [installation, maintenance]
            
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
            listDto.list = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/dictionaries"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
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

            let listDto = DictionaryListDto()
            listDto.list = [red, blue, green, lightBlue, darkBlue]
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
            listDto.list = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        server.GET["/fsm-mobile/configuration/priorities"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let listDto = PriorityListDto()
            listDto.list = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Item types
        server.GET["/fsm-mobile/configuration/item/types"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
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
            
            let listDto = ItemTypeListDto()
            listDto.list = [stb, cable]
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Item type classes
        server.GET["/fsm-mobile/configuration/item/types/class"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
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
            let listDto = ItemTypeClassListDto()
            listDto.itemTypesClasses = [equipment, materials, installedServices]
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Item type level
        server.GET["/fsm-mobile/configuration/item/types/level"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let level1 = ItemTypeLevelDto()
            level1.id = 1
            level1.code = "LEVEL1"
            level1.name = "Type"
            level1.isFinal = true
            
            let listDto = ItemTypeLevelListDto()
            listDto.itemTypesLevels = [level1]
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
            let done = StatusDto()
            done.id = 4
            done.code = "DONE"
            done.name = "Done"
            done.workRelated = false
            done.statusFlowType = [.task]
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
            
            let listDto = StatusListDto()
            listDto.list = [assigned, enRoute, inProgress, done, cancelled, inBox, installed]
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Configuration components
        server.GET["/fsm-mobile/configuration/components"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let tasksModule = ConfigurationComponentDto()
            tasksModule.code = .tasks
            tasksModule.type = .module
            tasksModule.sequence = 1
            
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
            
            let listDto = ConfigurationComponentListDto()
            listDto.list = [tasksModule, addAnnouncementButton, addItemButton, itemChangeStatusButton]
            listDto.componentByTypeList = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Task flags
        server.GET["/fsm-mobile/configuration/task/flags"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let flagInRisk = TaskFlagDto()
            flagInRisk.id = 1
            flagInRisk.code = "IN_RISK"
            flagInRisk.name = "In risk"
            let flagSLAExceeded = TaskFlagDto()
            flagSLAExceeded.id = 2
            flagSLAExceeded.code = "SLA_EXCEEDED"
            flagSLAExceeded.name = "SLA Exceeded"
            
            let listDto = TaskFlagListDto()
            listDto.list = [flagInRisk, flagSLAExceeded]
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Task types
        server.GET["/fsm-mobile/configuration/task/types"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let installation = TaskTypeDto()
            installation.id = 1
            installation.classCode = "FIELS_INSTALLATION_CLASS"
            installation.code = "FIELD_INSTALLATION"
            installation.flowId = 1
            installation.maxAttachmentNumber = 100
            installation.name = "Field Installation"
            let maintenance = TaskTypeDto()
            maintenance.id = 2
            maintenance.classCode = "GPON_CHECK_CLASS"
            maintenance.code = "GPON_CHECK"
            maintenance.flowId = 1
            maintenance.maxAttachmentNumber = 100
            maintenance.name = "GPON Check"
            
            let listDto = TaskTypeListDto()
            listDto.list = [installation, maintenance]
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Task ids
        server.GET["/fsm-mobile/tasks/my/ids"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let dto = TasksIdListDto()
            dto.ids = self.tasks.map { $0.key }
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
            let inProgress2Done = StatusTransitionDto()
            inProgress2Done.firstStatusId = 3
            inProgress2Done.nextStatusId = 4
            inProgress2Done.noteRendered = false
            inProgress2Done.noteRequired = false
            let inProgress2Cancelled = StatusTransitionDto()
            inProgress2Cancelled.firstStatusId = 3
            inProgress2Cancelled.nextStatusId = 5
            inProgress2Cancelled.noteRendered = false
            inProgress2Cancelled.noteRequired = false
            
            let installationFlow = StatusChangeConfigurationDto()
            installationFlow.objectTypeId = 1
            installationFlow.statusFlowList = [assigned2EnRoute, enRoute2InProgress, inProgress2Done, inProgress2Cancelled]
            
            let gponCheckFlow = StatusChangeConfigurationDto()
            gponCheckFlow.objectTypeId = 2
            gponCheckFlow.statusFlowList = [assigned2EnRoute, enRoute2InProgress, inProgress2Done, inProgress2Cancelled]
            
            let listDto = StatusChangeConfigurationListDto()
            listDto.list = [installationFlow, gponCheckFlow]
            return listDto.asValidRsponse(contentType: contentType)
        }
        // MARK: Tasks
        server.GET["/fsm-mobile/tasks/*"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let segments = request.path.split("/")
            let idString = segments[2]
            let ids = idString.split(",")
            
            let taskListDto = TaskListDto()
            taskListDto.list = []
            
            ids.compactMap{ Int32($0) }.forEach { id in
                if let taskDto = self.tasks[id] {
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

        // MARK: Create and get task's announcements
        server["/fsm-mobile/tasks/:id/task-items"] = { request in
            let contentType = request.headers["accept"] ?? "application/json"
            
            let taskId = Int32(request.params[":id"] ?? "") ?? 0
            
            switch request.method {
            case "GET":
                
                let listDto = TaskItemListDto()
                listDto.taskItems = self.taskItems.filter { $0.value.taskId == taskId }.map { $0.value }
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
                
                    let taskItemId = WebApplication.getRandomID()
                    inputDto.taskItemId = taskItemId
                    inputDto.taskId = taskId
                    self.taskItems[taskItemId] = inputDto
                    
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
            if let inputDto = try? JSONDecoder().decode(ItemDto.self, from: Data(bodyString.utf8)), let announcement = self.taskItems[announcementId] {
            
                let itemId = WebApplication.getRandomID()
                inputDto.id = itemId
                inputDto.statusId = 6
                inputDto.name = UUID().uuidString
                announcement.item = inputDto
                
                return announcement.asValidRsponse(contentType: contentType)
            }
            Logger.error("Invalid input body", bodyString)
            return .badRequest(nil)
        }
        
        // MARK: Delete task item
        server.DELETE["/fsm-mobile/tasks/1/task-items/:id"] = { request in
            let taksItemId = Int32(request.params[":id"] ?? "")
            self.taskItems = self.taskItems.filter { $0.value.taskItemId != taksItemId }
            return .noContent
        }
        
        // MARK: Change task status
        server.PUT["/fsm-mobile/tasks/:id/status"] = { request in

            guard let id = Int32(request.params[":id"] ?? ""), let taskDto = self.tasks[id] else {
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
                 
                let changeDto = DataChangeDto()
                changeDto.objectId = taskDto.id
                changeDto.changeType = .update
                changeDto.objectType = .task
                changeDto.id = 1
                self.dataChanges.append(changeDto)
                return .noContent
            }
        
            return .badRequest(nil)
             
         }
        
        // MARK: Edit attachment's comment
        server.POST["/fsm-mobile/attachments/editComment"] = { request in
            
            if let inputDto = try? JSONDecoder().decode(AttachmentCommentDto.self, from: Data(request.bodyString!.utf8)) {
                for task in self.tasks {
                    for attachment in task.value.attachmentsInfo ?? [] {
                        if attachment.id == inputDto.attachmentId {
                            attachment.comment = inputDto.comment
                        }
                    }
                }
            }
            return .noContent
        }
        
        // MARK: Update attachment's properties
        server.PUT["/fsm-mobile/attachments/:attachmentID/properties"] = { request in
            return .noContent
        }
        
        // MARK: Add note to task
        server.POST["/fsm-mobile/tasks/:taskID/notes"] = { request in
            
            if let inputDto = try? JSONDecoder().decode(TaskNotesDto.self, from: Data(request.bodyString!.utf8)),
                let taskID = Int32(request.params.first?.value ?? ""), let taskDto = self.tasks[taskID] {
                inputDto.notes.forEach { note in
                    note.externalId = WebApplication.getRandomID()
                    note.isFullNoteContentAvailable = true
                    taskDto.notes?.append(note)
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
            
            if self.dataChanges.isEmpty {
                return .noContent
            }
            
            let listDto = DataChangeListDto()
            listDto.list = self.dataChanges.map { $0 }
            self.dataChanges = []
            return listDto.asValidRsponse(contentType: contentType)
        }
        
        // MARK: Log app error
        server.POST["/fsm-mobile/logs/errors"] = { request in
            return .noContent
        }
        
        // MARK: Download attachment
        server.GET["/fsm-mobile/attachments/:fileID"] = { request in

            let filename = "attachment\(request.params.first?.value ?? "").jpg"
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

               return .raw(204, "OK", responseHeader, { writer in
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
    
    static func getRandomID() -> Int32 {
        WebApplication.randomID = WebApplication.randomID + 1
        return WebApplication.randomID
    }
}
