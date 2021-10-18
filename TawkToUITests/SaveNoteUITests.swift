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
    
    func test_note_added_to_db() {
        
        
//        let app = XCUIApplication()
//        app.tables/*@START_MENU_TOKEN@*/.staticTexts["https://api.github.com/users/pjhyett true"]/*[[".cells.staticTexts[\"https:\/\/api.github.com\/users\/pjhyett true\"]",".staticTexts[\"https:\/\/api.github.com\/users\/pjhyett true\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        app.scrollViews.otherElements.containing(.staticText, identifier:"Notes:").children(matching: .textView).element.tap()
//       
//      
////        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.staticTexts["Save"]/*[[".buttons[\"Save\"].staticTexts[\"Save\"]",".staticTexts[\"Save\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
//        
//        app.scrollViews.otherElements.containing(.button, identifier: "Save").element.tap()
//        app.alerts["Alert"].scrollViews.otherElements.buttons["OK"].tap()
//        
////        let alertDialog = app.alerts["Alert"].scrollViews.otherElements
////
////        XCTAssertTrue(alertDialog.element.exists)
////
////        alertDialog.buttons["OK"].tap()
//
        
    }
}
