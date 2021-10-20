//
//  UserDetailsApiTests.swift
//  TawkToTests
//
//  Created by Jyoti Luhana on 19/10/21.
//

import XCTest
@testable import TawkTo

class UserDetailsApiTests: XCTestCase {
    
    var sut: UserDetailsServices!
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try? super.setUpWithError()
        sut = UserDetailsServices()
        sut.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try? super.tearDownWithError()
    }
    
    func test_user_details_valid_api_response() {
        expectation = self.expectation(description: "user_details_valid_api_response")
        sut.fetchUserDetails(username: "mojombo")
        
        sut.onErrorHandling = { error in
            XCTAssertNil(error.reason)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_user_details_invalid_api_response() {
        expectation = self.expectation(description: "user_details_invalid_api_response")
        sut.fetchUserDetails(username: "mojo!")
        
        sut.onErrorHandling = { error in
            self.expectation.fulfill()
            XCTAssertNotNil(error.reason)
        }
        
        waitForExpectations(timeout: 15, handler: nil)
    }

}

extension UserDetailsApiTests: UserDetailsResponse {
    func didReceiveUserDetailsResponse(_ response: Users) {
        expectation.fulfill()
        XCTAssertNotNil(response)
        
        let userData = APIServices.sharedInstance.loadJson(filename: "Users", responseType: Users.self)
        if let userResponse = userData {
            XCTAssertEqual(response, userResponse)
        }
    }
    
}
