//
//  Enviroment.swift
//  lookbook
//
//  Created by Daniel Jones on 2/7/22.
//

import Foundation

enum Enviroment: String {
    case development = "development"
    case production = "production"
    
    var appID: String {
        switch self {
        case .development:
            return "ohanadevfam586950409690043"
        case .production:
            return "ohanafam27485939273899921861"
        }
    }
    
    var serverURL: String {
        switch self {
        case .development:
            return "https://ohanafam-dev-server.herokuapp.com/parse"
        case .production:
            return "https://ohanafam-server-prod.herokuapp.com/parse"
        }
    }
}
