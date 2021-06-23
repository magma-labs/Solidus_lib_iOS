//
//  User.swift
//  SolidusLib
//
//  Created by Paco Chacon de Dios on 10/07/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class User {

    public var id: Int = 0
    public var email: String = ""
    public var firstName: String = ""
    public var lastName: String = ""
    public var spreeAPIKey: String = ""
    public var createdAt: NSDate = NSDate()
    public var billAddress: Address? = nil
    public var shipAddress: Address? = nil

    required convenience public init?(map: Map) {
        self.init()
    }
}

extension User: Mappable {

    public func mapping(map: Map) {
        id <- map["id"]
        email <- map["email"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        spreeAPIKey <- map["spree_api_key"]
        createdAt <- map["created_at"]
        billAddress <- map["bill_address"]
        shipAddress <- map["ship_address"]
    }

}

extension User: Meta {

    static func url() -> String {
        return URLManager.getURL(with: Endpoint.users)
    }

}
