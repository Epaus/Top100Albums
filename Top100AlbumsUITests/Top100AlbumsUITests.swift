//
//  Top100AlbumsUITests.swift
//  Top100AlbumsUITests
//
//  Created by Estelle Paus on 6/18/20.
//  Copyright © 2020 Paus Productions. All rights reserved.
//

import XCTest

class Top100AlbumsUITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMainViewExists() throws {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.MainView"])
    }
    
    func testCellContainsAlbumNameLabel() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        let table = app.tables.matching(identifier: "listTableView")
        let cell = table.cells.element(matching: .cell, identifier: ConstantText.cellId)
        XCTAssertNotNil(cell)
        let albumLabel = cell.staticTexts["albumNameCell"]
        XCTAssertNotNil(albumLabel)
    }
    
    func testCellContainsArtistNameLabel() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        let table = app.tables.matching(identifier: "listTableView")
        let cell = table.cells.element(matching: .cell, identifier: ConstantText.cellId)
        let artistLabel = cell.staticTexts["artistNameCell"]
        XCTAssertNotNil(artistLabel)
    }
    
    func testCellContainsImage() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        let table = app.tables.matching(identifier: "listTableView")
        let cell = table.cells.element(matching: .cell, identifier: ConstantText.cellId)
        let element = cell.staticTexts["thumbnail"]
        XCTAssertNotNil(element)
    }
    
    func test_iTunesButtonExistsOnDetailView() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.DetailView"])
        let label = XCUIApplication().otherElements["linkButton"]
        XCTAssertNotNil(label)
    }
    
    func testDetailViewContainsCopyrightInfo() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.DetailView"])
        let copyrightLabel = XCUIApplication().otherElements["copyright"]
        XCTAssertNotNil(copyrightLabel)
    }
    
    func testDetailViewContainsAlbumName() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.DetailView"])
        let label = XCUIApplication().otherElements["albumName"]
        XCTAssertNotNil(label)
    }
    
    func testDetailViewContainsArtistName() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.DetailView"])
        let label = XCUIApplication().otherElements["artistName"]
        XCTAssertNotNil(label)
    }
    
    func testDetailViewContainsGenreLabel() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.DetailView"])
        let label = XCUIApplication().otherElements["genres"]
        XCTAssertNotNil(label)
    }
    
    func testDetailViewContainsLinkButton() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.DetailView"])
        let button = XCUIApplication().otherElements["linkButton"]
        XCTAssertNotNil(button)
    }
    
    func testDetailViewContainsReleaseDateLabel() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.DetailView"])
        let label = XCUIApplication().otherElements["releaseDate"]
        XCTAssertNotNil(label)
    }
    
    func testDetailViewContainsImage() {
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        XCTAssertNotNil(XCUIApplication().navigationBars["Top100Albums.DetailView"])
        let image = XCUIApplication().otherElements["thumbnail"]
        XCTAssertNotNil(image)
    }
    
    
}
