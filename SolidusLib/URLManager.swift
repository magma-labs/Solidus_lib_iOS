//
//  URLManager.swift
//  SolidusLib
//
//  Created by Daniel Contreras on 7/10/17.
//  Copyright © 2017 Magmalabs. All rights reserved.
//

import Foundation

class URLManager {

    static var urlServer = ""

    /// GetURL builds a url from the set urlServer variable
    ///
    /// - Parameter endpoint: Endpoint to use
    /// - Returns: A URL built from the urlServer and endpoint
    static func getURL(with endpoint: Endpoint) -> String {
        let url = "\(urlServer)\(endpoint.rawValue)"
        return url
    }

    /// GetURL builds a url from the set urlServer variable
    ///
    /// - Parameter string: A string to use
    /// - Returns: A URL built from the urlServer and string
    static func getURL(with string: String) -> String {
        let url = "\(urlServer)\(string)"
        return url
    }

}
