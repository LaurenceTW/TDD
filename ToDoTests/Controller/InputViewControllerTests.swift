//
//  InputViewControllerTests.swift
//  ToDo
//
//  Created by dasdom on 30.10.15.
//  Copyright © 2015 Dominik Hauser. All rights reserved.
//

import XCTest
@testable import ToDo
import CoreLocation

class InputViewControllerTests: XCTestCase {
    
    var sut: InputViewController!
    var placemark: MockPlacemark!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main",
            bundle: nil)
        sut = storyboard.instantiateViewControllerWithIdentifier(
            "InputViewController") as! InputViewController
        
        _ = sut.view    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_HasTitleTextField() {
        XCTAssertNotNil(sut.titleTextField)
    }
    
    func test_HasDateTextField() {
        XCTAssertNotNil(sut.dateTextField)
    }
    
    func test_HasLocationTextField() {
        XCTAssertNotNil(sut.locationTextField)
    }
    
    func test_HasAddressTextField() {
        XCTAssertNotNil(sut.addressTextField)
    }
    
    func test_HasDescriptionTextField() {
        XCTAssertNotNil(sut.descriptionTextField)
    }
    
    func test_HasSaveButton() {
        XCTAssertNotNil(sut.saveButton)
    }
    
    func test_HasCancelButton() {
        XCTAssertNotNil(sut.cancelButton)
    }

    
    func testSave_UsesGeocoderToGetCoordinateFromAddress() {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.locationTextField.text = "Office"
        sut.addressTextField.text = "Infinite Loop 1, Cupertino"
        sut.descriptionTextField.text = "Test Description"
        
        let mockGeocoder = MockGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        placemark = MockPlacemark()
        let coordinate = CLLocationCoordinate2DMake(37.3316851, -122.0300674)
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let item = sut.itemManager?.itemAtIndex(0)
        
        let testItem = ToDoItem(title: "Test Title",
            itemDescription: "Test Description",
            timestamp: 1456095600,
            location: Location(name: "Office", coordinate: coordinate))
        
        XCTAssertEqual(item, testItem)
    }
    
    func testSave_CreatesToDoItemWithTitleDateAndDescription() {
        sut.titleTextField.text = "Test Title"
        sut.dateTextField.text = "02/22/2016"
        sut.descriptionTextField.text = "Test Description"

        sut.itemManager = ItemManager()
        
        sut.save()
        
        let item = sut.itemManager?.itemAtIndex(0)
        
        let testItem = ToDoItem(title: "Test Title",
            itemDescription: "Test Description",
            timestamp: 1456095600,
            location: nil)
        
        XCTAssertEqual(item, testItem)
    }
    
    func testSave_CreatesToDoItemWithTitle() {
        sut.titleTextField.text = "Test Title"
        
        sut.itemManager = ItemManager()
        
        sut.save()
        
        let item = sut.itemManager?.itemAtIndex(0)
        
        let testItem = ToDoItem(title: "Test Title")
        
        XCTAssertEqual(item, testItem)
    }
    
    func test_SaveButtonHasSaveAction() {
        let button: UIButton = sut.saveButton
        
        guard let actions = button.actionsForTarget(sut,
            forControlEvent: .TouchUpInside) else {
                XCTFail(); return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }

}

extension InputViewControllerTests {
    class MockGeocoder: CLGeocoder {
        
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(addressString: String,
            completionHandler: CLGeocodeCompletionHandler) {
                
                self.completionHandler = completionHandler
        }
    }
    
    class MockPlacemark : CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D?
        
        override var location: CLLocation? {
            guard let coordinate = mockCoordinate else
            { return CLLocation() }
            
            return CLLocation(latitude: coordinate.latitude,
                longitude: coordinate.longitude)
        }
    }

}

