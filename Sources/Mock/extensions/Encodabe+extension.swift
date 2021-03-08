//
//  Encodable+extension.swift
//  
//
//  Created by Tomasz Kucharski on 29/12/2020.
//

import Foundation
import Swifter

extension Encodable {

    func asValidRsponse() -> HttpResponse {
        return HttpResponse.ok(.json(self))
    }

    func asInvalidRsponse() -> HttpResponse {
        return HttpResponse.badRequest(.json(self))
    }
}
