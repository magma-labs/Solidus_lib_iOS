//
//  Image.swift
//  SolidusLib
//
//  Created by Paco Chacon de Dios on 12/07/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation
import ObjectMapper


public class Image {

    public var id = 0
    public var position = 0
    public var miniUrl = ""
    public var smallUrl = ""
    public var productUrl = ""

    required convenience public init?(map: Map) {
        self.init()
    }
}

extension Image: Mappable {

    public func mapping(map: Map) {
        id          <- map["id"]
        position    <- map["position"]
        miniUrl     <- map["mini_url"]
        smallUrl    <- map["small_url"]
        productUrl  <- map["product_url"]
    }

}
