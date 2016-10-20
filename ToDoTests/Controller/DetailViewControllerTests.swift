//
//  DetailViewControllerTests.swift
//  ToDo
//
//  Created by dasdom on 28.10.15.
//  Copyright © 2015 Dominik Hauser. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
            bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier(
            "DetailViewController") as! DetailViewController
        
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
    }

    func test_HasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
    }
    
    func test_HasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
    }
    
    func test_HasDescriptionLabel() {
        XCTAssertNotNil(sut.locationLabel)
    }
    
    func test_HasMapView() {
        XCTAssertNotNil(sut.mapView)
    }
    
    func testSettingItemInfo_SetsTextsToLabels() {
        
        let coordinate = CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735)
        
        let itemManager = ItemManager()
        itemManager.addItem(ToDoItem(title: "The title",
            itemDescription: "The description",
            timestamp: 1456150025,
            location: Location(name: "Home", coordinate: coordinate)))
        
        sut.itemInfo = (itemManager, 0)
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "The title")
        XCTAssertEqual(sut.dateLabel.text, "02/22/2016")
        XCTAssertEqual(sut.locationLabel.text, "Home")
        XCTAssertEqual(sut.descriptionLabel.text, "The description")
        XCTAssertEqualWithAccuracy(sut.mapView.centerCoordinate.latitude,
            coordinate.latitude,
            accuracy: 0.001)
    }

    func testCheckItem_ChecksItemInItemManager() {
        
        let itemManager = ItemManager()
        itemManager.addItem(ToDoItem(title: "The title"))
        
        sut.itemInfo = (itemManager, 0)
        
        sut.checkItem()
        
        XCTAssertEqual(itemManager.toDoCount, 0)
        XCTAssertEqual(itemManager.doneCount, 1)
    }

}
