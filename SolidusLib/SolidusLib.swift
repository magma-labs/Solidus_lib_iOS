//
//  SolidusLib.swift
//  SolidusLib
//
//  Created by Daniel Contreras on 7/6/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

public struct Solidus {

    // This variable sets the API environment on which to work
    public var urlServer:String = "" {
        didSet {
            if urlServer != "" {
                URLManager.urlServer = urlServer
            }
        }
    }

    // This is used for the Solidus API requests
    public var XSpreeToken:String?

    public static var shared = Solidus()

    //MARK:- Orders
    public func getOrders(from page: Int, success:@escaping ([Order], Int, Int)->Void, fail:@escaping (_ error:Error)->Void) {
        let url = "\(Order.url())/mine?page=\(page)"

        request(url: url, method: .get, parameters: nil, headers: getTokenHeader(), success: { (result) in
            // Code
            if let ordersJSON = result["orders"] as? [[String:Any]] {
                let orders = Mapper<Order>().mapArray(JSONArray: ordersJSON)
                let currentPage = result["current_page"]as! Int
                let pages = result["pages"] as! Int
                success(orders, currentPage, pages)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }
    }

    public func getOrder(by number: String, success:@escaping (Order)->Void, fail:@escaping (_ error: Error)->Void) {
        let url = "\(Order.url())/\(number)"

        request(url: url, method: .get, parameters: nil, headers: getTokenHeader(), success: { (result) in
            if let order = Mapper<Order>().map(JSON: result) {
                success(order)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }
    }

    //MARK:- Users
    public func getUser(id: Int, success:@escaping (User)->Void, fail:@escaping (_ error: Error)->Void) {
        let url = "\(User.url())/\(id)"
        request(url: url, method: .get, parameters: nil, headers: getTokenHeader(), success: { (result) in
            if let user = Mapper<User>().map(JSON: result) {
                success(user)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }
    }

    public func updateUserPassword(id: Int, password: String, confirmPassword: String, success: @escaping (User) -> Void, fail: @escaping (_ error: Error) -> Void) {
        guard var headers = getTokenHeader() else { return }
        headers["Content-Type"] = "application/json"
        let parameters: Parameters = [
            "user": [
                "password": password,
                "password_confirmation": confirmPassword
            ]
        ]

        let url = "\(URLManager.getURL(with: .users))/\(id)/change_password"

        request(url: url, method: .put, parameters: parameters, headers: headers, success: { (result) in
            if let user = Mapper<User>().map(JSON: result) {
                success(user)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }
    }

    public func updateUser(id: Int, firstName: String, lastName: String, success: @escaping (User)-> Void, fail: @escaping (_ error: Error) -> Void) {
        guard var headers = getTokenHeader() else { return }
        headers["Content-Type"] = "application/json"
        let url = "\(URLManager.getURL(with: .users))/\(id)"
        let parameters: Parameters = [
            "first_name": firstName,
            "last_name": lastName
        ]

        request(url: url, method: .put, parameters: parameters, headers: headers, success: { (result) in
            if let user = Mapper<User>().map(JSON: result) {
                success(user)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }
    }

    //MARK:- Authentication
    public func authenticate(withGoogle token:String, success:@escaping (User)->Void, successNotSignedUp:@escaping ([String: Any])->Void, fail:@escaping (_ error:Error)->Void) {
        let url = URLManager.getURL(with: .googleSignin)
        let headers : HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: Parameters = ["id_token": token]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: Any] {
                    let user = json["user"] as? [String : Any]
                    
                    if let error = self.parseErrorFromResponse(json) {
                        if let user = user {
                            successNotSignedUp(user)
                        } else {
                            fail(error)
                        }
                        
                        return
                    }
                    
                    if let user = Mapper<User>().map(JSON: json) {
                        success(user)
                    } else {
                        fail(APIError())
                    }
                } else {
                    fail(APIError())
                }
            case .failure(let error):
                fail(error)
            }
        }
    }

    public func authenticate(with email: String, password: String, success: @escaping(User) -> Void, fail:@escaping (Error)->Void) {

        let parameters: Parameters = [
            "user": [
                "email": email,
                "password": password
            ]
        ]

        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let url = URLManager.getURL(with: .emailSignin)

        request(url: url, method: .post, parameters: parameters, headers: headers, success: { (result) in
            if let user = Mapper<User>().map(JSON: result) {
                success(user)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }

    }

    public func authenticate(withFacebook token: String, success: @escaping(User) -> Void, successNotSignedUp: @escaping([String: Any]) -> Void, fail: @escaping(_ error: Error) -> Void) {
        let url: String = URLManager.getURL(with: .facebookSignin)
        let headers : HTTPHeaders = ["Content-Type": "application/json"]
        let parameters: Parameters = ["id_token": token]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: Any] {
                    let user = json["user"] as? [String : Any]
                    
                    if let error = self.parseErrorFromResponse(json) {
                        if let user = user {
                            successNotSignedUp(user)
                        } else {
                            fail(error)
                        }
                        
                        return
                    }
                    
                    if let user = Mapper<User>().map(JSON: json) {
                        success(user)
                    } else {
                        fail(APIError())
                    }
                } else {
                    fail(APIError())
                }
            case .failure(let error):
                fail(error)
            }
        }
    }

    public func register(withGoogle token: String, email: String, firstName: String, lastName: String, success: @escaping(User) -> Void, fail:@escaping (Error)->Void) {

        let parameters: Parameters = [
            "id_token": token,
            "user": [
                "email": email,
                "first_name": firstName,
                "last_name": lastName
            ]
        ]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let url = URLManager.getURL(with: .googleSignup)

        request(url: url, method: .post, parameters: parameters, headers: headers, success: { (result) in
            if let user = Mapper<User>().map(JSON: result) {
                success(user)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }
    }

    public func register(with email: String, password: String, firstName: String, lastName: String, success: @escaping(User) -> Void, fail:@escaping (Error)->Void) {

        let parameters: Parameters = [
            "user": [
                "email": email,
                "password": password,
                "first_name": firstName,
                "last_name": lastName
            ]
        ]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let url = URLManager.getURL(with: .emailSignup)

        request(url: url, method: .post, parameters: parameters, headers: headers, success: { (result) in
            if let user = Mapper<User>().map(JSON: result) {
                success(user)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }
    }

    /// Function to register in store using Facebook information.
    ///
    /// - Parameters:
    ///   - token: User's Facebook ID token
    ///   - firstName: User's first name
    ///   - lastName: User's last name
    ///   - email: User's email
    ///   - success: If everything is ok, returns a user object.
    ///   - fail: If got any error during process, return an Error.
    public func register(withFacebook token: String, firstName: String, lastName: String, email: String, success: @escaping(User) -> Void, fail: @escaping(_ error: Error) -> Void) {

        let parameters: Parameters = [
            "id_token": token,
            "user": [
                "email": email,
                "first_name": firstName,
                "last_name": lastName
            ]
        ]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        let url = URLManager.getURL(with: .facebookSignup)

        request(url: url, method: .post, parameters: parameters, headers: headers, success: { (result) in
            if let user = Mapper<User>().map(JSON: result) {
                success(user)
            } else {
                fail(APIError())
            }
        }) { (error) in
            fail(error)
        }
    }

    public func getURL(with string: String) -> String {
        return URLManager.getURL(with: string)
    }

    //MARK:- Errors

    /// Parses any error from a response body
    ///
    /// - Parameter body: Response body to parse
    /// - Returns: Error if any, otherwise nil means there was no error
    func parseErrorFromResponse(_ body: [String: Any]) -> APIError? {
        // If error in body, get it, otherwise return nil (as theres no error)

        // The error body can come in either the "erros" or "error" format
        var errorBody:[String: Any]!

        if let errors = body["errors"] as? [String: [Any]] {
            var error: String! = ""
            if let errorsEmail = errors["email"] as? [String] {
                error = "email: \(errorsEmail.joined(separator: ","))"
            }
            if let errorsPassword = errors["password"] as? [String] {
                if error == "" {
                    error = "password: \(errorsPassword.joined(separator: ","))"
                } else {
                    error = error + "\npassword: \(errorsPassword.joined(separator: ","))"
                }
            }
            if let errorsPasswordConfirmation = errors["password_confirmation"] as? [String] {
                if error == "" {
                    error = "password_confirmation: \(errorsPasswordConfirmation.joined(separator: ","))"
                } else {
                    error = error + "\npassword_confirmation: \(errorsPasswordConfirmation.joined(separator: ","))"
                }
            }
            errorBody = ["message": error]
        } else if let error = body["error"] as? [String: Any] {
            errorBody = error
        } else if let error = body["error"] as? String {
            errorBody = ["message": error]
        } else {
            return nil
        }

        // Error Message - Defaults to 'Error, unable to perform request'
        var errorMessage:String?
        errorMessage = errorBody["message"] as? String

        // Return the error
        return APIError(message: errorMessage)
    }

    //MARK:- Private members
    fileprivate func getTokenHeader() -> [String:String]? {
        guard let token = XSpreeToken else { return nil }
        return ["X-Spree-Token" : token]
    }

    fileprivate func request(url:String, method:HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, success: @escaping([String: Any]) -> Void, fail: @escaping(_ error: Error) -> Void) {
        Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                if let json = response.result.value as? [String: Any] {
                    if let error = self.parseErrorFromResponse(json) {
                        fail(error)
                        return
                    }

                    success(json)
                } else {
                    fail(APIError())
                }
            case .failure(let error):
                fail(error)
            }
        }
    }

}
