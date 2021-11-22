//
//  WebApplication.swift
//  
//
//  Created by Tomasz Kucharski on 23/12/2020.
//

import Foundation
import Swifter

let resourcesPath = FileManager.default.currentDirectoryPath + String.pathSeparator + "Resources" + String.pathSeparator

class WebApplication {

    let storage = DataStorage()
    
    init(_ server: HttpServer) {

        server["/"] = { request, _ in
            return .notFound
        }

        server["/fsm-mobile"] = { request, _ in
            return .ok(.html("API mock"))
        }
        
        server.GET["/fsm-mobile/tenant/default"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let tenantDto = TenantDto()
            tenantDto.key = "Telco"
            return tenantDto.asValidRsponse()
        }
        
        server.GET["/fsm-mobile/apps/latest"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            var apiVersions = (0...40).map{ "3.\($0)" }
            if let contentType = request.headers["accept"], contentType.contains("application/vnd.comarch.fsm-") {
                let usedApiVersion = contentType.replacingOccurrences(of: "application/vnd.comarch.fsm-", with: "").replacingOccurrences(of: "+json", with: "")
                if !apiVersions.contains(usedApiVersion) {
                    apiVersions.append(usedApiVersion)
                }
            }
            let appVersion = request.headers["app-version"] ?? "master-snapshot"
            Logger.debug("New connection", "Connected app \(appVersion)")
            let latestDto = LatestDto()
            latestDto.version = appVersion
            latestDto.supportedApiVersions = []
            
            apiVersions.forEach { version in
                let apiVersionDto = ApiVersionDto()
                apiVersionDto.status = .CURRENT
                apiVersionDto.version = version
                latestDto.supportedApiVersions?.append(apiVersionDto)
            }
            return latestDto.asValidRsponse()
        }
        
        // MARK: login form
        server.GET["/auth/realms/:tenant/protocol/openid-connect/auth"] = { request, responseHeaders in
            let redirectUrl = request.queryParams.filter{ $0.0 == "redirect_uri" }.map{ $0.1 }.first ?? ""
            return HttpResponse.movedTemporarily("\(redirectUrl)?code=\(UUID().uuidString)")
        }

        // MARK: logout
        server.POST["/auth/realms/:tenant/protocol/openid-connect/logout"] = { request, responseHeaders in
            return .noContent
        }

        // MARK: keycloak token
        server.POST["/auth/realms/:tenant/protocol/openid-connect/token"] = { request, responseHeaders in
            
            let contentType = "application/json"
            let dto = OAuthAccessTokenDto()
            dto.accessToken = UUID().uuidString
            dto.expiresIn = 6000
            dto.refreshToken = UUID().uuidString
            dto.refreshExpiresIn = 6000
            return dto.asValidRsponse()
        }
        
        server.GET["/fsm-mobile/users/me"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            guard let userDto = (self.storage.users.filter{ $0.id == 1 }.first) else {
                return .internalServerError
            }
            return userDto.asValidRsponse()
        }
        
        server.GET["/fsm-mobile/configuration/locale/translations/:lang"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let translationsDto = TranslationsDto()
            translationsDto.locale = request.params.first?.value ?? ""
            translationsDto.translations = [:]
            return translationsDto.asValidRsponse()
        }
        
        server.PUT["/fsm-mobile/notifications/instanceId/:identifier"] = { request, responseHeaders in
            return .noContent
        }
        
        // MARK: features
        server.GET["/fsm-mobile/configuration/features"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let featureListDto = FeatureListDto()
            featureListDto.list = self.storage.features
            return featureListDto.asValidRsponse()
        }
        
        server.GET["/fsm-mobile/configuration/workorder/types"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = WorkOrderTypeListDto()
            listDto.list = self.storage.orderTypes
            
            return listDto.asValidRsponse()
        }
        
        server.GET["/fsm-mobile/attachments/types/forCreation"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = AttachmentTypeForCreationListDto()
            listDto.attachmentTypesForCreation = []
            return listDto.asValidRsponse()
        }
        
        server.GET["/fsm-mobile/configuration/properties/complex"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = ComplexPropertyListDto()
            listDto.list = []
            return listDto.asValidRsponse()
        }
        
        // MARK: system parameters
        server.GET["/fsm-mobile/configuration/systemparameters"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = SystemParameterListDto()
            listDto.list = self.storage.systemParameters
            return listDto.asValidRsponse()
        }
        
        // MARK: dictionaries
        server.GET["/fsm-mobile/dictionaries"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = DictionaryListDto()
            listDto.list = self.storage.dictionaries
            return listDto.asValidRsponse()
        }
        
        // MARK: note templates
        server.GET["/fsm-mobile/note/templates"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = NoteTemplateListDto()
            listDto.noteTemplates = []
            return listDto.asValidRsponse()
        }
        
        // MARK: status handlers
        server.GET["/fsm-mobile/configuration/statushandlers"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = StatusHandlerListDto()
            listDto.list = self.storage.statuShandlers
            return listDto.asValidRsponse()
        }
        
        // MARK: priorities
        server.GET["/fsm-mobile/configuration/priorities"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = PriorityListDto()
            listDto.list = self.storage.priorities
            return listDto.asValidRsponse()
        }
        
        // MARK: item types
        server.GET["/fsm-mobile/configuration/item/types"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = ItemTypeListDto()
            listDto.list = self.storage.itemTypes
            return listDto.asValidRsponse()
        }
        
        // MARK: item type classes
        server.GET["/fsm-mobile/configuration/item/types/class"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            
            let listDto = ItemTypeClassListDto()
            listDto.itemTypesClasses = self.storage.itemClasses
            return listDto.asValidRsponse()
        }
        
        // MARK: item type level
        server.GET["/fsm-mobile/configuration/item/types/level"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = ItemTypeLevelListDto()
            listDto.itemTypesLevels = self.storage.itemLevels
            return listDto.asValidRsponse()
        }
        
        // MARK: transfer types
        server.GET["/fsm-mobile/configuration/transfer/types"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let listDto = TransferTypeListDto()
            
            let type = TransferTypeDto()
            type.code = "NORMAL"
            type.customProperties = []
            type.flowId = 1
            type.id = 1
            type.name = "Normal"
            
            listDto.transferTypes = [type]
            return listDto.asValidRsponse()
        }
        
        // MARK: transfer status flow
        server.GET["/fsm-mobile/configuration/transfer/status/flows/:ids"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let listDto = StatusChangeConfigurationListDto()
            listDto.list = self.storage.transferStatusFlow
            return listDto.asValidRsponse()
        }
        
        // MARK: documents
        server.GET["/fsm-mobile/documents"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = DocumentListDto()
            listDto.list = []
            return listDto.asValidRsponse()
        }
        
        // MARK: my warehouse's items and by id
        server.GET["/fsm-mobile/items/*"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            self.storage.addBusinessDataForToday()
            let segments = request.path.split(separator: "/")
            let action = segments[2]
            
            switch action {
            case "my":
                let listDto = ItemListDto()
                listDto.items = self.storage.warehouseItems
                self.storage.dataChanges = self.storage.dataChanges.filter { $0.objectType != .item }
                return listDto.asValidRsponse()
            case "userItems":
                let listDto = ItemListDto()
                listDto.items = self.storage.warehouseItems
                return listDto.asValidRsponse()
            default:
                let ids = action.split(separator: ",")
                let listDto = ItemListDto()
                listDto.items = []
                
                ids.compactMap{ Int32($0) }.forEach { id in
                    if let itemDto = (self.storage.warehouseItems.filter{ $0.id == id }.first) {
                        listDto.items?.append(itemDto)
                    }
                }
                return listDto.asValidRsponse()
            }
            
        }
        
        // MARK: warehouses
        server.GET["/fsm-mobile/warehouses/transfer/available-to-transfer"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = WarehouseListDto()
            listDto.warehouseList = self.storage.warehouses.filter{ $0.id != 1 }
            return listDto.asValidRsponse()
        }
        
        // MARK: transfers' ids
        server.GET["/fsm-mobile/transfers/my/ids"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let listDto = TransfersIdListDto()
            listDto.ids = self.storage.transfers.compactMap { $0.id }
            return listDto.asValidRsponse()
        }
        
        server.GET["/fsm-mobile/transfers/:ids"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let listDto = TransferListDto()
            listDto.transferDtos = []
            
            let ids = request.params[":ids"]?.split(separator: ",")
            ids?.compactMap{ Int32($0) }.forEach { id in
                if let transferDto = (self.storage.transfers.filter{ $0.id == id }.first) {
                    listDto.transferDtos?.append(transferDto)
                }
            }
        
            return listDto.asValidRsponse()
        }
        
        // MARK: create transfer
        server.POST["/fsm-mobile/transfers/create"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            if let inputDto = try? JSONDecoder().decode(TransferItemListDto.self, from: Data(request.body)) {
                

                let listDto = TransferCreateDetailsListDto()
                listDto.transferCreateDetailsDtos = []
                inputDto.transferItems?.forEach { transferItem in
                    if let item = (self.storage.warehouseItems.filter { $0.id == transferItem.itemId }.first),
                        let destinationWarehouse = (self.storage.warehouses.filter{ $0.id == transferItem.destinationWarehouseId }.first),
                        let me = (self.storage.users.filter{ $0.id == 1 }.first),
                        let sourceWarehouse = (self.storage.warehouses.filter { $0.name == me.fullName }.first) {
                        
                        let transfer = TransferDto()
                        transfer.createUser = me
                        transfer.destinationWarehouse = destinationWarehouse
                        transfer.id = DtoMaker.getUniqueID()
                        transfer.bussinesKey = "TR/\(transfer.id ?? 0)/\(DtoMaker.currentYear())"
                        transfer.item = item
                        transfer.quantity = transferItem.quantity ?? 1.0
                        transfer.sourceWarehouse = sourceWarehouse
                        transfer.transitions = []
                        transfer.statusId = 8
                        transfer.typeId = 1
                        transfer.transferRange = TimeRangeDto().set(from: Date(), to: Date().dateAdding(dayCount: 2))
                        
                        
                        self.storage.transfers.append(transfer)
                        self.storage.warehouseItems = self.storage.warehouseItems.filter { $0.id != item.id }
                        self.storage.dataChanges.append(DtoMaker.makeDataChangeDto(.transfer, .insert, transfer.id))
                        self.storage.dataChanges.append(DtoMaker.makeDataChangeDto(.item, .delete, item.id))
                        
                        let transferItem = TransferItemDto()
                        transferItem.destinationWarehouseId = destinationWarehouse.id
                        transferItem.itemId = item.id
                        transferItem.quantity = transfer.quantity
                        let detailsDto = TransferCreateDetailsDto()
                        detailsDto.transferId = transfer.id
                        detailsDto.status = .success
                        detailsDto.transferItemDto = transferItem
                        listDto.transferCreateDetailsDtos?.append(detailsDto)
                    }
                    
                }
                return listDto.asValidRsponse()
            }
            return .noContent
        }
        
        server.GET["/fsm-mobile/audits/filter"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let auditFiltersDto = AuditFiltersDto()
            auditFiltersDto.idsAndPredefinedAnswers = [:]
            auditFiltersDto.sectionNames = []
            
            return auditFiltersDto.asValidRsponse()
        }
        
        // MARK: countries
        server.GET["/fsm-mobile/locations/countries"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = CountryListDto()
            listDto.countries = []
            
            let pl = CountryDto()
            pl.id = 1
            pl.code = "PL"
            pl.name = "Poland"
            listDto.countries?.append(pl)
            let de = CountryDto()
            de.id = 2
            de.code = "DE"
            de.name = "Germany"
            listDto.countries?.append(de)
            return listDto.asValidRsponse()
        }
        
        server.GET["/fsm-mobile/configuration/realTime"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let dto = RealTimeConfigurationDto()
            dto.hoursInFuture = 2
            dto.hoursInPast = 2
            return dto.asValidRsponse()
        }
        
        // MARK: statuses
        server.GET["/fsm-mobile/configuration/statuses"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = StatusListDto()
            listDto.list = self.storage.statuses
            return listDto.asValidRsponse()
        }
        
        // MARK: user's work status
        server.GET["/fsm-mobile/users/workStatus/config"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
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
            return dto.asValidRsponse()
        }
        
        // MARK: change user's status
        server.PUT["/fsm-mobile/users/workStatus/technicianChangeStatus"] = { request, responseHeaders in
            return .noContent
        }
        
        // MARK: change employee's status
        server.PUT["/fsm-mobile/users/workStatus/supervisorChangeStatus"] = { request, responseHeaders in
            return .noContent
        }
        
        // MARK: configuration components
        server.GET["/fsm-mobile/configuration/components"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = ConfigurationComponentListDto()
            listDto.list = self.storage.components
            listDto.componentByTypeList = []
            return listDto.asValidRsponse()
        }
        
        // MARK: task flags
        server.GET["/fsm-mobile/configuration/task/flags"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = TaskFlagListDto()
            listDto.list = self.storage.taskFlags
            return listDto.asValidRsponse()
        }
        
        // MARK: task types
        server.GET["/fsm-mobile/configuration/task/types"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = TaskTypeListDto()
            listDto.list = self.storage.taskTypes
            return listDto.asValidRsponse()
        }
        
        // MARK: task ids
        server.GET["/fsm-mobile/tasks/my/ids"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            self.storage.addBusinessDataForToday()

            let dto = TasksIdListDto()
            dto.ids = self.storage.tasks.compactMap { $0.id }
            
            self.storage.dataChanges = self.storage.dataChanges.filter { $0.objectType != .task }
            return dto.asValidRsponse()
        }

        // MARK: item status flow
        server.GET["/fsm-mobile/configuration/item/status/flows/*"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
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
            return listDto.asValidRsponse()
        }

        // MARK: task status flow
        server.GET["/fsm-mobile/configuration/task/status/flows/:ids"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = StatusChangeConfigurationListDto()
            listDto.list = self.storage.taskStatusFlow
            return listDto.asValidRsponse()
        }
        // MARK: tasks
        server.GET["/fsm-mobile/tasks/*"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)

            self.storage.addBusinessDataForToday()
            
            let segments = request.path.split(separator: "/")
            let action = segments[2]
            
            switch action {
            case "isCurrentUserAssignable":
                let dto = AssignToResourceValidationDto()
                dto.canAssignToResource = true
                return dto.asValidRsponse()
            case "availableResources":
                let listDto = TaskReassignDataListDto()
                let resourceType = request.queryParams.filter { $0.0 == "resourceType" }.first?.1 ?? ""
                switch resourceType {
                case "EMPLOYEE":
                    listDto.taskReassignDataDtoList = self.storage.users.map { TaskReassignDataDto.make(from: $0) }
                default:
                    listDto.taskReassignDataDtoList = (1...7).map { _ in TaskReassignDataDto.makeGroup() }
                }
                return listDto.asValidRsponse()
            case "allVisibleTasks":
                let dto = PaginatedTaskListDto()
                dto.currentPage = 1
                dto.pageAmount = 1
                dto.tasks = self.storage.foreignTasks.map { BasicTaskDto(taskDto: $0) }
                return dto.asValidRsponse()
            default:
                let ids = action.split(separator: ",")
                let taskListDto = TaskListDto()
                taskListDto.list = []
                
                ids.compactMap{ Int32($0) }.forEach { id in
                    if let taskDto = (self.storage.tasks.filter{ $0.id == id }.first) {
                        taskListDto.list?.append(taskDto)
                    }
                }
                ids.compactMap{ Int32($0) }.forEach { id in
                    if let taskDto = (self.storage.foreignTasks.filter{ $0.id == id }.first) {
                        taskListDto.list?.append(taskDto)
                    }
                }
                
                return taskListDto.asValidRsponse()
            }
        }
        
        // MARK: transfer requests
        server.GET["/fsm-mobile/transfer-requests/*"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)

            self.storage.addBusinessDataForToday()
            
            let segments = request.path.split(separator: "/")
            let action = segments[2]
            let ids = action.split(separator: ",")
            let listDto = TransferRequestListDto()
            listDto.transferRequestDtos = []
            
            ids.compactMap{ Int32($0) }.forEach { id in
               
            }
            
            return listDto.asValidRsponse()
        }
        
        // MARK: create task
        server.POST["/fsm-mobile/workorders"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let dto = WorkOrderBasicDataDto()
            dto.workOrderId = DtoMaker.getUniqueID()
            dto.workOrderBusinessKey = "WO/\(dto.workOrderId ?? 0)/\(DtoMaker.currentYear())"
            dto.taskId = DtoMaker.getUniqueID()
            dto.taskBusinessKey = "T/\(dto.taskId ?? 0)/\(DtoMaker.currentYear())"
            return dto.asValidRsponse()
        }

        // MARK: task's complexes
        server.GET["/fsm-mobile/tasks/:id/complexes"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = ComplexPropertyListDto()
            listDto.list = []
            return listDto.asValidRsponse()
        }
        
        // MARK: start task's track record
        server.PUT["/fsm-mobile/tasks/*/startTaskTracking"] = { request, responseHeaders in
            return .noContent
        }
        
        // MARK: end task's track record
        server.PUT["/fsm-mobile/tasks/*/endTaskTracking"] = { request, responseHeaders in
            return .noContent
        }
        
        server.GET["/fsm-mobile/reporters"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)

            let listDto = TaskReportingUserListDto()
            listDto.taskReportingUsers = self.storage.users.map {
                let dto = TaskReportingUserDto()
                dto.fullName = $0.fullName
                dto.phoneNumber = "500 893 123"
                return dto
            }
            return listDto.asValidRsponse()
        }
        
        // MARK: create task configuration
        server.GET["/fsm-mobile/configuration/workorder/types/forCreation"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let taskTypeFieldInstallation = TaskTypeForCreationDto()
            taskTypeFieldInstallation.typeId = 1

            let taskTypeGPONCheck = TaskTypeForCreationDto()
            taskTypeGPONCheck.typeId = 2
            
            let technologyGPON = TechnologyForCreationDto()
            technologyGPON.technologyId = 1
            technologyGPON.technologyName = "GPON"
            technologyGPON.taskTypesForCreation = [taskTypeFieldInstallation, taskTypeGPONCheck]
            
            let technologyFTTH = TechnologyForCreationDto()
            technologyFTTH.technologyId = 2
            technologyFTTH.technologyName = "FTTH"
            technologyFTTH.taskTypesForCreation = [taskTypeFieldInstallation]
            
            let technologyDSL = TechnologyForCreationDto()
            technologyDSL.technologyId = 3
            technologyDSL.technologyName = "DSL"
            technologyDSL.taskTypesForCreation = [taskTypeFieldInstallation]
            
            let workOrderInstallation = WorkOrderTypeForCreationDto()
            workOrderInstallation.typeId = 1
            workOrderInstallation.technologiesForCreation = [technologyGPON, technologyFTTH]
            
            let workOrderMaintenance = WorkOrderTypeForCreationDto()
            workOrderMaintenance.typeId = 2
            workOrderMaintenance.technologiesForCreation = [technologyGPON, technologyDSL]
            
            let listDto = WorkOrderTypesForCreationListDto()
            listDto.workOrderTypesForCreation = [workOrderInstallation, workOrderMaintenance]
            return listDto.asValidRsponse()
        }
        
        // MARK: create task's sites
        server.GET["/fsm-mobile/sites"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = SiteListDto()
            listDto.pageCount = 1
            listDto.resultCount = 2
            listDto.sites = []
            
            let site1 = SiteDto()
            site1.id = 1
            site1.name = "BTS antenna"
            site1.location = LocationDto()
            site1.location?.latitude = 51.759445
            site1.location?.longitude = 19.457216
            site1.location?.id = 1
            site1.location?.city = "Lodz"
            site1.location?.street = "Pilsudskiego"
            site1.location?.buildingNo = "12"
            listDto.sites?.append(site1)
            
            
            let site2 = SiteDto()
            site2.id = 2
            site2.name = "Server room"
            site2.location = LocationDto()
            site2.location?.latitude = 51.769445
            site2.location?.longitude = 19.467216
            site2.location?.city = "Lodz"
            site2.location?.id = 2
            site2.location?.street = "Targowa"
            site2.location?.buildingNo = "33"
            listDto.sites?.append(site2)
            return listDto.asValidRsponse()
        }
        
        // MARK: create task's impact items
        server.GET["/fsm-mobile/items/typesByClassCode"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let itemClassCode = request.queryParams.filter { $0.0 == "itemClassCode" }.first?.1
            let listDto = ItemTypeImpactListDto()
            listDto.list = self.storage.itemTypes.filter { $0.itemClass == itemClassCode }.map { itemType in
                let dto = ItemTypeImpactDto()
                dto.id = itemType.id
                dto.name = itemType.typeName
                return dto
            }
            return listDto.asValidRsponse()
        }
        
        // MARK: create task tab
        server.GET["/fsm-mobile/workorders/creation/tab"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            

            let section = TaskTabSectionDto()
            section.sequence = 1
            section.sectionName = "Attributes"
            section.tabSectionItems = []
            section.tabSectionItems?.append(TaskBuilder.makeFormRow(1, question: "Is urgent?", type: "INPUT_BOOLEAN"))
            section.tabSectionItems?.append(TaskBuilder.makeFormRow(2, question: "Assign to", type: "CREATE_WORK_ORDER_INPUT_RESOURCE"))
            section.tabSectionItems?.append(TaskBuilder.makeFormRow(3, question: "Impact", type: "INPUT_TASK_IMPACT").setStringValue("INSTALLED_SERVICES"))
            
            section.tabSectionItems?.append(TaskBuilder.makeFormRow(4, question: "Location Range", type: "INPUT_TASK_LOCATION_RANGE"))
            
            section.tabSectionItems?.append(TaskBuilder.makeFormRow(5, question: "Reporting user", type: "CREATE_WORK_ORDER_INPUT_REPORTING_USER"))
            section.tabSectionItems?.append(TaskBuilder.makeFormRow(6, question: "Description", type: "INPUT_TEXT"))
            section.tabSectionItems?.append(TaskBuilder.makeFormRow(7, question: "Site", type: "INPUT_SITE"))
            let inputSite = TaskBuilder.makeFormRow(8, question: "Site location", type: "INPUT_SITE_LOCATION")
            inputSite.code = "INPUT_SITE_LOCATION"
            section.tabSectionItems?.append(inputSite)
            
            let tab = TaskTabDto()
            tab.sequence = 1
            tab.tabName = "General info"
            tab.tabSections = [section]
            tab.type = "STATIC_DATA"
            return tab.asValidRsponse()
        }

        // MARK: create and get task's announcements
        server["/fsm-mobile/tasks/:id/task-items"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let taskId = Int32(request.params[":id"] ?? "") ?? 0
            
            switch request.method {
            case .GET:
                
                let listDto = TaskItemListDto()
                listDto.taskItems = self.storage.taskItems.filter { $0.taskId == taskId }
                switch listDto.taskItems?.count ?? 0 {
                case 0:
                    return .noContent
                default:
                    return listDto.asValidRsponse()
                }
                
            case .POST:
                guard !request.body.isEmpty else {
                    Logger.error("Input data", "Empty request body")
                    return .badRequest(nil)
                }
                if let inputDto = try? JSONDecoder().decode(TaskItemDto.self, from: Data(request.body)) {
                
                    let taskItemId = DtoMaker.getUniqueID()
                    inputDto.taskItemId = taskItemId
                    inputDto.taskId = taskId
                    self.storage.taskItems.append(inputDto)
                    
                    let listDto = TaskItemListDto()
                    listDto.taskItems = [inputDto]
                    return listDto.asValidRsponse()
                }
                Logger.error("Invalid input body", String(bytes: request.body, encoding: .utf8) ?? "")
                return .badRequest(nil)
            default:
                return .notAcceptable
            }
            
        }
        // MARK: add item to announcement
        server.POST["/fsm-mobile/tasks/*/task-items/:announcementId/item"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
        
            let announcementId = Int32(request.params[":announcementId"] ?? "") ?? 0
            guard !request.body.isEmpty else {
                Logger.error("Input data", "Empty request body")
                return .badRequest(nil)
            }
            if let inputDto = try? JSONDecoder().decode(ItemDto.self, from: Data(request.body)), let announcement = (self.storage.taskItems.filter { $0.taskItemId == announcementId }.first) {
            
                if let existingItem = (self.storage.warehouseItems.filter { $0.id == inputDto.id }.first) {
                    self.storage.warehouseItems = self.storage.warehouseItems.filter { $0.id != inputDto.id }
                    self.storage.dataChanges.append(DtoMaker.makeDataChangeDto(.item, .delete, existingItem.id))
                    announcement.item = existingItem
                } else {
                    let itemId = DtoMaker.getUniqueID()
                    inputDto.id = itemId
                    inputDto.statusId = 6
                    inputDto.name = self.storage.itemTypes.filter { $0.id == inputDto.itemTypeId }.first?.typeName ?? "invalid"
                    announcement.item = inputDto
                }
                return announcement.asValidRsponse()
            }
            Logger.error("Invalid input body", String(bytes: request.body, encoding: .utf8) ?? "")
            return .badRequest(nil)
        }
        
        // MARK: delete task item
        server.DELETE["/fsm-mobile/tasks/*/task-items/:id"] = { request, responseHeaders in
            let taksItemId = Int32(request.params[":id"] ?? "")
            self.storage.taskItems = self.storage.taskItems.filter { $0.taskItemId != taksItemId }
            return .noContent
        }
        
        // MARK: change task status
        server.PUT["/fsm-mobile/tasks/:id/status"] = { request, responseHeaders in

            guard let id = Int32(request.params[":id"] ?? ""), let taskDto = (self.storage.tasks.filter { $0.id == id }.first) else {
                Logger.error("Status change", "Invalid task id \(request.path)")
                return .badRequest(nil)
            }
             
            guard !request.body.isEmpty else {
                Logger.error("Input data", "Empty request body")
                return .badRequest(nil)
            }
             
            let inputDto = try? JSONDecoder().decode(TaskStatusChangeChainDto.self, from: Data(request.body))
            if let statusChange = (inputDto?.taskStatusChangeChainDto?.sorted { $0.sequence ?? 0 < $1.sequence ?? 0 }.last) {
                taskDto.statusId = statusChange.statusId
                 
                let changeDto = DtoMaker.makeDataChangeDto(.task, .update, taskDto.id)
                self.storage.dataChanges.append(changeDto)

                self.storage.addBusinessDataForToday()
                return .noContent
            }
        
            return .badRequest(nil)
             
         }
        
        // MARK: edit attachment's comment
        server.POST["/fsm-mobile/attachments/editComment"] = { request, responseHeaders in
            
            if let inputDto = try? JSONDecoder().decode(AttachmentCommentDto.self, from: Data(request.body)) {
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
        
        // MARK: detele attachment from task
        server.DELETE["/fsm-mobile/attachments/:attachmentId/delete"] = { request, responseHeaders in
            let attachmentId = Int32(request.params[":attachmentId"] ?? "")
            for task in self.storage.tasks {
                task.attachmentsInfo = task.attachmentsInfo?.filter { $0.id != attachmentId }
            }
            return .noContent
        }
        
        // MARK: upload attachment
        server.POST["/fsm-mobile/attachments/upload"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
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
            return dto.asValidRsponse()
        }
        
        // MARK: update attachment's properties
        server.PUT["/fsm-mobile/attachments/:attachmentID/properties"] = { request, responseHeaders in
            return .noContent
        }
        
        // MARK: add note to task
        server.POST["/fsm-mobile/tasks/:taskID/notes"] = { request, responseHeaders in
            
            if let inputDto = try? JSONDecoder().decode(TaskNotesDto.self, from: Data(request.body)),
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
        server.GET["/fsm-mobile/configuration/calendar/eventtypes"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            let listDto = CalendarEventTypeListDto()
            listDto.list = self.storage.calendarEventTypes
            return listDto.asValidRsponse()
        }
        
        // MARK: calendar
        server.GET["/fsm-mobile/calendars/*"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
                        
            self.storage.addBusinessDataForToday()

            let segments = request.path.split(separator: "/")
            let action = segments[2]
            
            switch action {
            case "my":
                let listDto = CalendarEventListDto()
                listDto.events = self.storage.calendarEvents
                self.storage.dataChanges = self.storage.dataChanges.filter { $0.objectType != .calendarEvent }
                return listDto.asValidRsponse()
            default:
                let ids = action.split(separator: ",")
                let listDto = CalendarEventListDto()
                listDto.events = []
                
                ids.compactMap{ Int32($0) }.forEach { id in
                    if let calendarDto = (self.storage.calendarEvents.filter{ $0.id == id }.first) {
                        listDto.events?.append(calendarDto)
                    }
                }
                return listDto.asValidRsponse()
            }
            
            
        }
        
        // MARK: calendar version
        server.GET["/fsm-mobile/calendars/my/version"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            return .ok(.data(UUID().uuidString.data(using: .utf8)!))
        }
        
        // MARK: create new calendar event
        server.POST["/fsm-mobile/calendars/create"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let dto = CalendarUpdateResultDto()
            dto.id = DtoMaker.getUniqueID()
            dto.calendarVersion = UUID().uuidString
            return dto.asValidRsponse()
        }
        
        // MARK: messages
        server.GET["/fsm-mobile/messages/*"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            self.storage.addBusinessDataForToday()
            
            let segments = request.path.split(separator: "/")
            let action = segments[2]
            switch action {
            case "my":
                self.storage.dataChanges = self.storage.dataChanges.filter { $0.objectType != .message }
                let listDto = MessageListDto()
                listDto.list = self.storage.messages
                return listDto.asValidRsponse()
            case "recipients":
                let listDto = UserListDto()
                listDto.users = self.storage.users.filter { $0.id != 1 }
                return listDto.asValidRsponse()
            default:
                let ids = action.split(separator: ",")
                let listDto = MessageListDto()
                listDto.list = []
                
                ids.compactMap{ Int32($0) }.forEach { id in
                    if let messageDto = (self.storage.messages.filter{ $0.id == id }.first) {
                        listDto.list?.append(messageDto)
                    }
                }
                return listDto.asValidRsponse()
            }
            
        }
        
        // MARK: send message
        server.POST["/fsm-mobile/messages/send"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
                
            if let messageDto = try? JSONDecoder().decode(MessageDto.self, from: Data(request.body)),
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
                return messageDto.asValidRsponse()
            }
            return .noContent
        }
        
        server.PUT["/fsm-mobile/messages"] = { request, responseHeaders in
            
            if let messageListDto = try? JSONDecoder().decode(MessageListDto.self, from: Data(request.body)) {
                (messageListDto.list ?? []).forEach { dto in
                    if let status = dto.status, let message = (self.storage.messages.filter { $0.id == dto.id }.first) {
                        message.status = status
                    }
                }
            }
            
            return .noContent
        }
        
        // MARK: supervised users
        server.GET["/fsm-mobile/users/subordinate"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let listDto = SupervisedUserDtoList()
            listDto.users = self.storage.users.map { SupervisedUserDto.make(userDto: $0) }
            listDto.users?.filter{ $0.id == 1 }.first?.employeePosition = EmployeePositionDto.make(self.storage.gpsPosition)
            listDto.users?.filter{ $0.id == 1 }.first?.tasks = self.storage.tasks.filter{ $0.scheduledRealizationTime?.dateFrom ?? Date() > Date.startOfDay() && $0.scheduledRealizationTime?.dateFrom ?? Date() < Date.endOfDay() }.map { TaskSimpleDto.make($0) }
            return listDto.asValidRsponse()
        }
        
        // MARK: Report GPS position
        server.POST["/fsm-mobile/gps/position"] = { request, responseHeaders in
            if let inputDto = try? JSONDecoder().decode(GpsPositionsDto.self, from: Data(request.body)) {
                self.storage.gpsPosition = inputDto.positions?.first
            }
            return .noContent
        }
        
        // MARK: Get data changes
        server.GET["/fsm-mobile/notifications/my/notdownloaded"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            self.storage.addBusinessDataForToday()
            
            if self.storage.dataChanges.isEmpty {
                return .noContent
            }
            
            let listDto = DataChangeListDto()
            listDto.list = self.storage.dataChanges.map { $0 }
            self.storage.dataChanges = []
            return listDto.asValidRsponse()
        }
        
        // MARK: Log app error
        server.POST["/fsm-mobile/logs/errors"] = { request, responseHeaders in
        
            guard !request.body.isEmpty else {
                Logger.error("Input data", "Empty request body")
                return .badRequest(nil)
            }
            if let inputDto = try? JSONDecoder().decode(ErrorLogDto.self, from: Data(request.body)) {
                Logger.info("", "--------------------------------")
                Logger.info("Incoming log", inputDto.label ?? "")
                //Logger.info("Incoming log", inputDto.report ?? "")
            }
            return .noContent
        }
        
        // MARK: Download attachment
        server.GET["/fsm-mobile/attachments/:fileID"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            
            //let filename = "attachment\(request.params.first?.value ?? "").jpg"
            let filename = "attachment1.jpg"
            do {
               let filePath = resourcesPath + filename
               Logger.info("Open file", filePath)
               let file = try filePath.openForReading()
               //let mimeType = filePath.mimeType()

               let attr = try FileManager.default.attributesOfItem(atPath: filePath)
               if let fileSize = attr[FileAttributeKey.size] as? UInt64 {
                   responseHeaders.addHeader("Content-Length", String(fileSize))
               }

               return .raw(200, "OK", { writer in
                   try writer.write(file)
                   file.close()
               })
               
            } catch {
               Logger.error("Avatar problem", "\(error.localizedDescription)")
               return .notFound
            }
            
        }
        
        // MARK: Download avatar
        server.GET["/fsm-mobile/users/avatar/:id"] = { request, responseHeaders in
            self.prepareContentType(request, responseHeaders)
            let filename = "avatar\(request.params.first?.value ?? "").jpg"
            do {
                let filePath = resourcesPath + filename
                Logger.info("Open file", filePath)
                let file = try filePath.openForReading()
                //let mimeType = filePath.mimeType()

                let attr = try FileManager.default.attributesOfItem(atPath: filePath)
                if let fileSize = attr[FileAttributeKey.size] as? UInt64 {
                    responseHeaders.addHeader("Content-Length", String(fileSize))
                }

                return .raw(200, "OK", { writer in
                    try writer.write(file)
                    file.close()
                })
                
            } catch {
                Logger.error("Avatar problem", "\(error.localizedDescription)")
                return .notFound
            }
        }
        
        server.notFoundHandler = { request, responseHeaders in
            Logger.error("Unhandled request", "\(request.method) `\(request.path)`")
            return .notFound
        }
        
        server.middleware.append { request, responseHeaders in
            Logger.info("Incoming request", "\(request.method) \(request.path)")
            return nil
        }
    }
    
    func prepareContentType(_ request: HttpRequest, _ responseHeaders: HttpResponseHeaders) {
        if let accept = request.headers["accept"], accept.contains("application/vnd.comarch.fsm-") {
            responseHeaders.addHeader("Content-Type", accept)
        }
    }
}
