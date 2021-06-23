//
//  Country.swift
//  SolidusLib
//
//  Created by Paco Chacon de Dios on 11/07/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class Country {

    public var id: Int = 0
    public var isoName: String = ""
    public var iso: String = ""
    public var iso3: String = ""
    public var name: String  = ""
    public var numCode: Int = 0

    required convenience public init?(map: Map) {
        self.init()
    }
}

extension Country: Mappable {

    public func mapping(map: Map) {
        id <- map["id"]
        isoName <- map["iso_name"]
        iso <- map["iso"]
        iso3 <- map["iso3"]
        name <- map["name"]
        numCode <- map["numcode"]
    }

}
