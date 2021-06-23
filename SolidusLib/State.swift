//
//  State.swift
//  SolidusLib
//
//  Created by Paco Chacon de Dios on 11/07/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class State {
    public var id: Int = 0
    public var name: String = ""
    public var abbr: String = ""
    public var countryId: Int = 0

    required convenience public init?(map: Map) {
        self.init()
    }
}

extension State: Mappable {

    public func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        abbr <- map["abbr"]
        countryId <- map["country_id"]
    }

}
