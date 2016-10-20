//
//  ToDoItemTests.swift
//  ToDo
//
//  Created by dasdom on 23.09.15.
//  Copyright © 2015 Dominik Hauser. All rights reserved.
//

import XCTest
@testable import ToDo

class ToDoItemTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit_ShouldSetTitle() {
        let item = ToDoItem(title: "Test title")
        XCTAssertEqual(item.title, "Test title",
            "Initializer should set the item title")
    }
    
    func testInit_ShouldSetTitleAndDescription() {
        let item = ToDoItem(title: "Test title",
            itemDescription: "Test description")
        XCTAssertEqual(item.itemDescription , "Test description",
            "Initializer should set the item description")
    }
    
    func testInit_ShouldSetTitleAndDescriptionAndTimestamp() {
        let item = ToDoItem(title: "Test title",
            itemDescription: "Test description",
            timestamp: 0.0)
        XCTAssertEqual(0.0, item.timestamp,
            "Initializer should set the timestamp")
    }
    
    func testInit_ShouldTakeTitleAndDescriptionAndDueDateAndLocation() {
        let location = Location(name: "Test name")
        let item = ToDoItem(title: "Test title",
            itemDescription: "Test description",
            timestamp: 0.0,
            location: location)
        
        XCTAssertEqual(location, item.location,
            "Initializer should set the location")
    }
    
    func testEqualItems_ShouldBeEqual() {
        let firstItem = ToDoItem(title: "First")
        let secondItem = ToDoItem(title: "First")
        
        XCTAssertEqual(firstItem, secondItem)
    }
    
    func testWhenLocationDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timestamp: 0.0,
            location: Location(name: "Home"))
        let secondItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timestamp: 0.0,
            location: Location(name: "Office"))
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenOneLocationIsNilAndTheOtherIsnt_ShouldBeNotEqual() {
        var firstItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timestamp: 0.0,
            location: nil)
        var secondItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timestamp: 0.0,
            location: Location(name: "Office"))
        
        XCTAssertNotEqual(firstItem, secondItem)
        
        firstItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timestamp: 0.0,
            location: Location(name: "Home"))
        secondItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timestamp: 0.0,
            location: nil)
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTimestampDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timestamp: 1.0)
        let secondItem = ToDoItem(title: "First title",
            itemDescription: "First description",
            timestamp: 0.0)
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenDescriptionDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title",
            itemDescription: "First description")
        let secondItem = ToDoItem(title: "First title",
            itemDescription: "Second description")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }
    
    func testWhenTitleDifferes_ShouldBeNotEqual() {
        let firstItem = ToDoItem(title: "First title")
        let secondItem = ToDoItem(title: "Second title")
        
        XCTAssertNotEqual(firstItem, secondItem)
    }


}
