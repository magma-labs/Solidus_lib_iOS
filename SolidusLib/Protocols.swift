//
//  Protocols.swift
//  SolidusLib
//
//  Created by Daniel Contreras on 7/7/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation

/// Models can comply to this and make their
/// network requests easier to perform and parse
/// url is the value from which to work with this model
/// childName is the name of the root node from the JSON response
@objc protocol Meta {

    static func url() -> String
    @objc optional static func childName() -> String
}
