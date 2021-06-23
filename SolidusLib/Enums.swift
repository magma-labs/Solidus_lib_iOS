//
//  Enums.swift
//  SolidusLib
//
//  Created by Daniel Contreras on 7/7/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation

enum Endpoint: String {

    case products = "/api/products"
    case orders = "/api/orders"
    case users = "/api/users"
    case countries = "/api/countries"
    case states = "/api/states"
    case googleSignin = "/api/authentication/google/signin"
    case googleSignup = "/api/authentication/google/signup"
    case emailSignin = "/api/authentication/email/signin"
    case emailSignup = "/api/authentication/email/signup"
    case facebookSignin = "/api/authentication/facebook/signin"
    case facebookSignup = "/api/authentication/facebook/signup"
}
