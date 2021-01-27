//
//  WebApplication.swift
//  
//
//  Created by Tomasz Kucharski on 23/12/2020.
//

import Foundation

class WebApplication {
    
    init(_ server: HttpServer) {

        server.GET["/"] = { request in
            return .notFound
        }
    }
}
