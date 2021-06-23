//
//  LineItem.swift
//  SolidusLib
//
//  Created by Paco Chacon de Dios on 12/07/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class LineItem {
    public var id = 0
    public var quantity = 0
    public var price = ""
    public var variantId = 0
    public var variant: Product!

    public required convenience init?(map: Map) {
        self.init()
    }
}

extension LineItem: Mappable {

    public func mapping(map: Map) {
        id      <- map["id"]
        quantity    <- map["quantity"]
        price    <- map["price"]
        variantId      <- map["variant_id"]
        variant      <- map["variant"]
    }

}
