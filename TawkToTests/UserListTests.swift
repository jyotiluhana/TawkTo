//
//  UserListTests.swift
//  TawkToTests
//
//  Created by Jyoti Luhana on 14/10/21.
//

import XCTest
@testable import TawkTo

class UserListTests: XCTestCase {
    
    var sut : UserListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try? super.setUpWithError()
        sut = UserListViewModel()
        getUserData()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        try? super.tearDownWithError()
    }

    func testUserListGetUserListForIndex() {
        let result = sut.getModelForIndex(0)
        XCTAssertNotNil(result)
    }

    func getUserData() {
        let userListCoordinator = UserListCoordinator()
        userListCoordinator.delegate = self
        userListCoordinator.fetchUserDataFromJson()
    }
}

extension UserListTests: UserListResponse {
    func didRecieveUserListResponse(_ response: [Users]) {
        self.sut.users.append(contentsOf: response)
    }
}
