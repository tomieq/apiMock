//
//  Encodable+extension.swift
//  
//
//  Created by Tomasz Kucharski on 29/12/2020.
//

import Foundation

extension Encodable {

    func asValidRsponse(contentType: String) -> HttpResponse {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return HttpResponse.ok(HttpResponseBody.data(jsonData, contentType: contentType))
        } catch {
            return HttpResponse.internalServerError
        }
    }

    func asInvalidRsponse(contentType: String) -> HttpResponse {
        do {
            let jsonData = try JSONEncoder().encode(self)
            return HttpResponse.badRequest(HttpResponseBody.data(jsonData, contentType: contentType))
        } catch {
            return HttpResponse.internalServerError
        }
    }
}
