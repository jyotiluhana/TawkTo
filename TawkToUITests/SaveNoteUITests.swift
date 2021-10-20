//
//  SaveNoteUITests.swift
//  TawkToUITests
//
//  Created by Jyoti Luhana on 18/10/21.
//

import XCTest

class SaveNoteUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_alert_button_on_save_note() {
        let app = XCUIApplication()
        let complaintsTable = app.tables["UsersTableView"]
        XCTAssertTrue(complaintsTable.exists, "Table does not exist")
        
        let complaintCell = complaintsTable.cells.firstMatch
        XCTAssert(complaintCell.exists)
        complaintCell.tap()
        
        let textView = app.scrollViews.otherElements.textViews["notes_txt"]
        XCTAssert(textView.exists)
        textView.tap()
        
        let saveButton = app.scrollViews.otherElements.staticTexts["Save"]
        XCTAssert(saveButton.exists)
        saveButton.tap()
        
        let alertDialog = app.alerts["Alert"].scrollViews.otherElements
        XCTAssertTrue(alertDialog.element.exists)
        alertDialog.buttons["OK"].tap()
    }
}
