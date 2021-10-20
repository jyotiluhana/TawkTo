//
//  UserListApiTests.swift
//  TawkToTests
//
//  Created by Jyoti Luhana on 18/10/21.
//

import XCTest
@testable import TawkTo

class UserListApiTests: XCTestCase {
    
    var sut: UserListServices!
    var expectation: XCTestExpectation!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try? super.setUpWithError()
        sut = UserListServices()
        sut.delegate = self
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try? super.tearDownWithError()
    }
    
    func test_userList_valid_api_response() {
        expectation = self.expectation(description: "userList_valid_api_response")
        sut.fetchUserList(withSince: 0)
        
        sut.onErrorHandling = { error in
            XCTAssertNil(error.reason)
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    

}

extension UserListApiTests: UserListResponse {
    func didRecieveUserListResponse(_ response: [Users]) {
        expectation.fulfill()
        XCTAssertNotNil(response)
        XCTAssert(response.count > 0)
        
        let userData = APIServices.sharedInstance.loadJson(filename: "UserList", responseType: [Users].self)
        if let userResponse = userData {
            XCTAssertEqual(response, userResponse)
        }
    }
}
