//
//  CalorieTrackerUITests.swift
//  CalorieTrackerUITests
//
//  Created by Shahin on 2020-02-25.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import XCTest

class CalorieTrackerUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
    }

    func testAddingFoodToToday() {
        
        let app = XCUIApplication()
        app.launch()

        let tablesQuery = app.tables
        let mockBreakfast10StaticText = tablesQuery.staticTexts["Mock Breakfast 10"]
        XCTAssertTrue(mockBreakfast10StaticText.exists)
        mockBreakfast10StaticText.tap()
        app.sheets.scrollViews.otherElements.buttons["Add Food to Today"].tap()
    }
    
    func testRemovigFoodFromToday() {
        
        let app = XCUIApplication()
        app.launch()
        
        let tablesQuery = app.tables
        let mockBreakfast10StaticText = tablesQuery.staticTexts["Mock Breakfast 10"]
        app.tabBars.children(matching: .button).element(boundBy: 1).tap()
        mockBreakfast10StaticText.tap()
        XCTAssertTrue(tablesQuery.staticTexts["Mock Breakfast 10"].exists)
        XCTAssertTrue(app.staticTexts["Total"].exists)
        mockBreakfast10StaticText.swipeLeft()
        XCTAssertTrue(tablesQuery.buttons["trailing0"].exists)
        tablesQuery.buttons["trailing0"].tap()
        XCTAssertFalse(app.staticTexts["489"].exists)
        
    }
    
    func testAddNewFood() {
        
        let app = XCUIApplication()
        app.launch()

        let addButton = app.navigationBars["Foods"].buttons["Add"]
        XCTAssertTrue(addButton.exists)
        addButton.tap()

        let addNewFoodNavigationBar = app.navigationBars["Add New Food"]
        addNewFoodNavigationBar.buttons["Cancel"].tap()
        addButton.tap()
        addNewFoodNavigationBar.buttons["Save"].tap()
        XCTAssertTrue(app/*@START_MENU_TOKEN@*/.staticTexts["Add"]/*[[".buttons[\"Add\"].staticTexts[\"Add\"]",".staticTexts[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        
    }
    
    
    func testDeleteFood() {
        
        let app = XCUIApplication()
        app.launch()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Mock Dinner 5"]/*[[".cells.staticTexts[\"Mock Dinner 5\"]",".staticTexts[\"Mock Dinner 5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets.scrollViews.otherElements.buttons["Delete Food"].tap()
        app.alerts["You are about to permanently delete a food from your list"].scrollViews.otherElements.buttons["Cancel"].tap()
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Mock Dinner 5"]/*[[".cells.staticTexts[\"Mock Dinner 5\"]",".staticTexts[\"Mock Dinner 5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.sheets.scrollViews.otherElements.buttons["Delete Food"].tap()
        app.alerts["You are about to permanently delete a food from your list"].scrollViews.otherElements.buttons["Delete"].tap()
        XCTAssertFalse(app.tables/*@START_MENU_TOKEN@*/.staticTexts["Mock Dinner 5"]/*[[".cells.staticTexts[\"Mock Dinner 5\"]",".staticTexts[\"Mock Dinner 5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.exists)
        
    }
    
    func testTrends() {
        
        let app = XCUIApplication()
        app.launch()
        app.tabBars.children(matching: .button).element(boundBy: 2).tap()
        
        let button = app/*@START_MENU_TOKEN@*/.buttons["30 Days"]/*[[".segmentedControls.buttons[\"30 Days\"]",".buttons[\"30 Days\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        button.tap()
        app/*@START_MENU_TOKEN@*/.buttons["7 Days"]/*[[".segmentedControls.buttons[\"7 Days\"]",".buttons[\"7 Days\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Today"]/*[[".cells.staticTexts[\"Today\"]",".staticTexts[\"Today\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Today"].buttons["Cancel"].tap()
        collectionViewsQuery/*@START_MENU_TOKEN@*/.staticTexts["Yesterday"]/*[[".cells.staticTexts[\"Yesterday\"]",".staticTexts[\"Yesterday\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Yesterday"].buttons["Cancel"].tap()
        button.tap()
        
        let itemButton = app.navigationBars["Trends"].buttons["Item"]
        itemButton.tap()
        app.navigationBars["30-day Trends"].buttons["Trends"].tap()
    }
}

