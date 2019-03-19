//
//  ErrorResponse.swift
//  TMDB
//
//  Created by Cyber - Sahil Ratnani on 19/03/19.
//  Copyright © 2019 heady.io. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
