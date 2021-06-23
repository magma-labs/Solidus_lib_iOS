//
//  APIError.swift
//  SolidusLib
//
//  Created by Daniel Contreras on 7/17/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

/// Errors returned from the API
class APIError: NSError {

    var message: String = "Unable to perform request, please try again later"


    /// Initializer
    ///
    /// - Parameters:
    ///   - message: Message for error, will default to "Error, unable to perform request" if nil
    ///   - errorType: Error Type, default to .Unknown if nil
    ///   - code: Code, defaults to 0
    init(message: String? = nil, code: Int = 0) {
        // Message
        if message != nil {
            self.message = message!
        }

        // Super
        super.init(
            domain: "com.app.solidus",
            code: code,
            userInfo: [
                NSLocalizedDescriptionKey: self.message
            ]
        )
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
