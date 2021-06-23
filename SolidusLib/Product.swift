//
//  Product.swift
//  SolidusLib
//
//  Created by Paco Chacon de Dios on 12/07/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class Product {

    public var id = 0
    public var name = ""
    public var price = ""
    public var displayPrice = ""
    public var weight = ""
    public var height = ""
    public var productDescription = ""
    public var images: [Image]!

    required convenience public init?(map: Map) {
        self.init()
    }

}

extension Product: Mappable {

    public func mapping(map: Map) {
        id      <- map["id"]
        name    <- map["name"]
        price    <- map["price"]
        displayPrice    <- map["display_price"]
        weight  <- map["weight"]
        height  <- map["height"]
        productDescription    <- map["description"]
        images      <- map["images"]
    }

}
