//
//  Order.swift
//  SolidusLib
//
//  Created by Daniel Contreras on 7/10/17.
//  Copyright © 2017 Magmalabs. All rights reserved.
//

import Foundation
import ObjectMapper

public class Order {

    public var id = 0
    public var number = ""
    public var itemTotal = ""
    public var total = ""
    public var totalQuantity = 0
    public var state = ""
    public var replaceProduct = 0
    public var specialInstructions = ""
    public var createdAt = ""
    public var completedAt = ""
    public var token = ""
    public var lineItems: [LineItem]!
    public var coveredByStoreCredit = false
    public var orderTotalAfterStoreCredit = ""
    public var totalApplicableStoreCredit = ""
    public var billAddress: Address!
    public var shipAddress: Address!

    required convenience public init?(map: Map) {
        self.init()
    }
}

extension Order: Mappable {

    public func mapping(map: Map) {
        id      <- map["id"]
        number    <- map["number"]
        itemTotal    <- map["display_item_total"]
        total    <- map["display_total"]
        totalQuantity    <- map["total_quantity"]
        state    <- map["state"]
        createdAt   <- map["created_at"]
        completedAt <- map["completed_at"]
        token       <- map["token"]
        lineItems   <- map["line_items"]
        coveredByStoreCredit    <- map["covered_by_store_credit"]
        orderTotalAfterStoreCredit  <- map["display_order_total_after_store_credit"]
        totalApplicableStoreCredit  <- map["display_total_applicable_store_credit"]
        billAddress <- map["bill_address"]
        shipAddress <- map["ship_address"]
    }

}

extension Order: Meta {

    static func url() -> String {
        return URLManager.getURL(with: Endpoint.orders)
    }

}
