//
//  Enviroment.swift
//  lookbook
//
//  Created by Daniel Jones on 2/7/22.
//

import Foundation

public enum Environment: String {
    case development = "Development"
    case production = "Production"
    
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

class Configuration {
    static var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "Development") != nil {
                return .development
            }
        }
        
        return .production
    }() 
}
