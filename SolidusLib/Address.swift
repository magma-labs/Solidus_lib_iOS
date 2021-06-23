//
//  Address.swift
//  SolidusLib
//
//  Created by Paco Chacon de Dios on 10/07/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation
import ObjectMapper

public class Address {

    public var id: Int = 0
    public var firstName: String = ""
    public var lastName: String = ""
    public var fullName: String = ""
    public var addrress1: String = ""
    public var address2: String = ""
    public var cityName: String = ""
    public var zipCode: String = ""
    public var phone: String = ""
    public var company: String = ""
    public var alternativePhone: String = ""
    public var countryId: Int = 0
    public var stateId: Int = 0
    public var stateName: String = ""
    public var stateText: String = ""
    public var country: Country? = nil
    public var state: State? = nil

    required convenience public init?(map: Map) {
        self.init()
    }
}

extension Address: Mappable {

    public func mapping(map: Map) {
        id <- map["id"]
        firstName <- map["firstname"]
        lastName <- map["lastname"]
        fullName <- map["full_name"]
        addrress1 <- map["address1"]
        address2 <- map["address2"]
        cityName <- map["city"]
        zipCode <- map["zipcode"]
        phone <- map["phone"]
        company <- map["company"]
        alternativePhone <- map["alternative_phone"]
        countryId <- map["country_id"]
        stateId <- map["state_id"]
        stateName <- map["state_name"]
        stateText <- map["state_text"]
        country <- map["country"]
        state <- map["state"]
    }

}
