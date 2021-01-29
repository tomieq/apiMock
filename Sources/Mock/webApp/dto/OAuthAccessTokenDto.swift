//
//  OAuthAccessTokenDto.swift
//  
//
//  Created by Tomasz Kucharski on 27/01/2021.
//

import Foundation

class OAuthAccessTokenDto: Codable {

    var accessToken: String?
    var expiresIn: Int32?
    var refreshToken: String?
    var refreshExpiresIn: Int32?
    var tokenType: String?
    var notBeforePolicy: Int32?
    var sessionState: String?
    var scope: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshExpiresIn = "refresh_expires_in"
        case tokenType = "token_type"
        case notBeforePolicy = "not-before-policy"
        case sessionState = "session_state"
        case scope
    }
}
