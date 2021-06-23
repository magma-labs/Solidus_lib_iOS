//
//  SolidusLibTests.swift
//  SolidusLibTests
//
//  Created by Daniel Contreras on 7/6/17.
//  Copyright © 2017 Magma Labs. All rights reserved.
//

import XCTest
@testable import SolidusLib

class SolidusLibTests: XCTestCase {
    
    let googleIdToken = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjVmNzkxZjZiMTdjYjlhZTcyMzA4MTJlNzFlZGJlNGExMGI3NGJmOGMifQ.eyJhenAiOiI4NjM2ODYyNjkzOTEtODNqZ2lkNmRyaG1xYWFwa3YwOWw1cjNnNDFtOTA5YWguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI4NjM2ODYyNjkzOTEtODNqZ2lkNmRyaG1xYWFwa3YwOWw1cjNnNDFtOTA5YWguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTIzOTczNTc4NTg1MzIyODg3MTciLCJoZCI6Im1hZ21hbGFicy5pbyIsImVtYWlsIjoiZGFuaWVsLmNvbnRyZXJhc0BtYWdtYWxhYnMuaW8iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6ImRXWEttVnNkQ015bktDamhCempia2ciLCJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJpYXQiOjE1MDEyNjAyODUsImV4cCI6MTUwMTI2Mzg4NX0.SVUSN6U6z2BblF5d0a1RePciqP88nHVykNBhP44ObAVKGHhOCE2YXJSjFK4J17Gxf5nD53NHhf-X2nRt5ylCWp9LHUtWisIYOajmgcifmRElQMD5OIOoiSyefrVQZjzSUzvntXA52qsPoX-UJXjLW8fae8xCpnN1hAv-nR4oitj4eTgAa_x6AD6KQgWJOz_Ix3WtV4XHhCiYjdUDzVP28uDc9vBdM2oVRDsLBc5L73xxpfWHY0PCAZjth4s0UCqyI9HzVDaDLxqMco_6FVCftfayGeTzQ97SYL4Vn7H6SvZk6VI9UcInD2X5qJKU0yd4HteOAmbubfac4jAKlM5qXQ"
    
    let facebookToken = "EAACuUrUZCMLQBAG2bm2T6hnHCLaWt8DG9uwSmiEmiLOTiYZBEZC9pjk0ZBd91aeIGgr1feJ7zSXw2YefdVoGDt7sQpBKJVDSGi4AyUHZAPdgFZBFCcNt5qwmEzLdzTvpdNiyli15TPTlxZB7KVvIzhuhpmoo85NB66s6iHxAw0HD6z5MrdRlx02z9gix4ZAHj9IZCnJlxANlhaMBSO3zOJp2NOIKhCyocSkIZBff46FiK95wZDZD"
    
    let testEmail = "test@magmalabs.io"
    let testPassword = "test123"
    
    // Note this token is modified each time the test testUpdateUserPassword is ran.
    // To get the latest token, update using the credentials:
    // testpassword@magmalabs.io
    // test123
    let updatePasswordToken = "8ca0c4e2bede76119e10ac725d07889e4df3d84cb82734b2"

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        Solidus.shared.urlServer = "https://solidus-lib.herokuapp.com"
        Solidus.shared.XSpreeToken = "49162c83edb8e0f5fac3e901c0a7b1e790661458d44853f6"
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetOrders() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        Solidus.shared.getOrders(from: 1, success: { (orders, currentPage, pages) in
            XCTAssertEqual(1, currentPage)
            XCTAssertTrue((pages > 0))
            XCTAssertNotNil(orders)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testGetOrderByNumber() {
        let ex = expectation(description: "Get order number R256635157")
        
        Solidus.shared.getOrder(by: "R256635157", success: { (order) in
            XCTAssertNotNil(order)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testGetUser() {
        let ex = expectation(description: "Expecting to get user 10")
        
        Solidus.shared.getUser(id: 10, success: { (user) in
            XCTAssertNotNil(user)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testGetURLWithString() {
        let url = "\(Solidus.shared.urlServer)testString"
        XCTAssertEqual(Solidus.shared.getURL(with: "testString"), url)
    }
    
    func testSignUpWithGoogle() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        Solidus.shared.register(withGoogle: googleIdToken, email: "daniel.contreras@magmalabs.io", firstName: "Daniel", lastName: "Contreras", success: { (user) in
            XCTAssertNotNil(user)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    /// This tests a successful request for a not signed up user.
    /// The idToken will most likely need to be updated before running the test.
    /// Please note, do not completethe signup process for the user with which you are tesing,
    /// otherwise, a new not-signed-up user would need to be used.
    func testSignInWithGoogleNotSignedUp() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        Solidus.shared.authenticate(withGoogle: googleIdToken, success: { (user) in
            XCTFail("User has already signed up")
            ex.fulfill()
        }, successNotSignedUp: { (dict) in
            XCTAssertNotNil(dict)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    /// This tests a successful request for a signed up user.
    /// The idToken will most likely need to be updated before running the test.
    func testSignInWithGoogleSignedUp() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        Solidus.shared.authenticate(withGoogle: googleIdToken, success: { (user) in
            XCTAssertNotNil(user)
            ex.fulfill()
        }, successNotSignedUp: { (dict) in
            XCTFail("User has not signed up")
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    /// This tests a signup error.
    /// Do not modify this token.
    func testSignUpWithGoogleInvalidTokenError() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        let wrongIdToken = "ERRORtoken"
        
        Solidus.shared.register(withGoogle: wrongIdToken, email: "daniel.contreras@magmalabs.io", firstName: "Daniel", lastName: "Contreras", success: { (user) in
            XCTFail("Token should not work")
            ex.fulfill()
        }) { (error) in
            XCTAssertEqual(error.localizedDescription, "Invalid token provided")
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testSignInWithEmail() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        Solidus.shared.authenticate(with: testEmail, password: testPassword, success: { (user) in
            XCTAssertNotNil(user)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testSignInWithEmailWrongPassword() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        Solidus.shared.authenticate(with: testEmail, password: "WRONGtest123", success: { (user) in
            XCTFail("Invalid credentials should not log in")
            ex.fulfill()
        }) { (error) in
            XCTAssertEqual(error.localizedDescription, "User not found")
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testSignUpWithEmail() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        let randomEmail = "test_\(getRandomString(with: 5))@magmalabs.io"
        
        Solidus.shared.register(with: randomEmail, password: "test123", firstName: "testFirst", lastName: "testLast", success: { (user) in
            XCTAssertNotNil(user)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testSignUpWithEmailExistingUser() {
        let ex = expectation(description: "Expecting a not nil JSON response")
        
        Solidus.shared.register(with: "test@magmalabs.io", password: "test123", firstName: "testFirst", lastName: "testLast", success: { (user) in
            XCTFail("User should already be registered")
            ex.fulfill()
        }) { (error) in
            XCTAssertEqual(error.localizedDescription, "email: has already been taken")
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testAuthenticateWithFacebookInvalidTokenError() {
        let ex = expectation(description: "Fail signing in using facebook fake token")

        Solidus.shared.authenticate(withFacebook: "FakeToken", success: { (user) in
            XCTFail("Should not exist this user because token is fake")
            ex.fulfill()
        }, successNotSignedUp: { (result) in
            XCTFail("Token is invalid, should not accept it")
            ex.fulfill()
        }) { (error) in
            XCTAssertNotNil(error.localizedDescription)
            ex.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testAuthenticateWithFacebook() {
        let ex = expectation(description: "Do a successful sign in with facebook")

        Solidus.shared.authenticate(withFacebook: facebookToken, success: { (user) in
            XCTAssertNotNil(user)
            ex.fulfill()
        }, successNotSignedUp: { (result) in
            XCTFail("User should be signed up")
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }

        waitForExpectations(timeout: 10, handler: { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        })
    }

    func testSignUpWithFacebookUsingUsingInvalidTokenShouldFail() {
        let ex = expectation(description: "Expecting an error for using an invalid token")

        Solidus.shared.register(withFacebook: "FakeToken", firstName: "FirstName", lastName: "LastName", email: "test@facebook.com", success: { (user) in
            XCTFail("Should not success because is using an invalid token")
            ex.fulfill()
        }) { (error) in
            XCTAssertNotNil(error.localizedDescription)
            ex.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testSignUpWithFacebookSuccessfully() {
        let ex = expectation(description: "Do a successfully sign up using facebook")

        Solidus.shared.register(withFacebook: facebookToken, firstName: "Facebook", lastName: "Test", email: "test@facebook.com", success: { (user) in
            XCTAssertNotNil(user)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testUpdateUserPasswordShouldFailUsingShortPassword() {
        let ex = expectation(description: "Change password of user 10 should fail because password is to short")

        Solidus.shared.updateUserPassword(id: 10, password: "new", confirmPassword: "new", success: { (user) in
            XCTFail("Password should not be changed because new password is too short")
            ex.fulfill()
        }) { (error) in
            XCTAssertEqual(error.localizedDescription, "password: is too short (minimum is 6 characters)")
            ex.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testUpdateUserPasswordShouldFailPasswordAndConfirmationNotEqual() {
        let ex = expectation(description: "Change password of user 10 should fail because password and confirmaton don't match")

        Solidus.shared.updateUserPassword(id: 10, password: "newpass1", confirmPassword: "newpass2", success: { (user) in
            XCTFail("Password should not be changed because new password doesn't match with confirmation")
            ex.fulfill()
        }) { (error) in
            XCTAssertEqual(error.localizedDescription, "password_confirmation: doesn't match Password")
            ex.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testUpdateUserPassword() {
        let ex = expectation(description: "Change password of user 77")
        
        Solidus.shared.XSpreeToken = updatePasswordToken

        Solidus.shared.updateUserPassword(id: 77, password: testPassword, confirmPassword: testPassword, success: { (user) in
            XCTAssertNotNil(user)
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
    
    func testUpdateProfileSuccessful() {
        let ex = expectation(description: "User should be updated properly")

        Solidus.shared.updateUser(id: 10, firstName: "Test", lastName: "Update", success: { (user) in
            XCTAssertEqual(user.firstName, "Test")
            XCTAssertEqual(user.lastName, "Update")
            ex.fulfill()
        }) { (error) in
            XCTFail(error.localizedDescription)
            ex.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }

    func testUpdateProfileFailUsingAnInvalidToken() {
        let ex = expectation(description: "User should not be updated because is trying to update a different user")

        Solidus.shared.updateUser(id: 23, firstName: "Test", lastName: "Fail", success: { (user) in
            XCTFail("Should not be able to modify user 23")
            ex.fulfill()
        }) { (error) in
            XCTAssertNotNil(error.localizedDescription)
            ex.fulfill()
        }

        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
    }
}

extension SolidusLibTests {

    func getRandomString(with length: Int) -> String {
        var randomString = ""
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

        for _ in 1...length {
            let randomIndex  = Int(arc4random_uniform(UInt32(letters.characters.count)))
            let a = letters.index(letters.startIndex, offsetBy: randomIndex)
            randomString +=  String(letters[a])
        }

        return randomString
    }

}
