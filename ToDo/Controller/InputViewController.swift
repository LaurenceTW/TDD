//
//  InputViewController.swift
//  ToDo
//
//  Created by dasdom on 30.10.15.
//  Copyright © 2015 Dominik Hauser. All rights reserved.
//

import UIKit
import CoreLocation

class InputViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    lazy var geocoder = CLGeocoder()
    
    var itemManager: ItemManager?
    
    let dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter
    }()
    
    @IBAction func save() {
        guard let titleString = titleTextField.text
            where titleString.characters.count > 0 else { return }
        
        let date: NSDate?
        if let dateText = self.dateTextField.text
            where dateText.characters.count > 0 {
                date = dateFormatter.dateFromString(dateText)
        } else {
            date = nil
        }
        
        let descriptionString: String?
        if descriptionTextField.text?.characters.count > 0 {
            descriptionString = descriptionTextField.text
        } else {
            descriptionString = nil
        }
        
        if let locationName = locationTextField.text
            where locationName.characters.count > 0 {
                if let address = addressTextField.text
                    where address.characters.count > 0 {
                        
                        geocoder.geocodeAddressString(address) {
                            [unowned self] (placeMarks, error) -> Void in
                            
                            let placeMark = placeMarks?.first
                            
                            let item = ToDoItem(title: titleString,
                                itemDescription: descriptionString,
                                timestamp: date?.timeIntervalSince1970,
                                location: Location(name: locationName,
                                    coordinate: placeMark?.location?.coordinate))
                            
                            self.itemManager?.addItem(item)
                        }
                } else {
                    let item = ToDoItem(title: titleString,
                        itemDescription: descriptionString,
                        timestamp: date?.timeIntervalSince1970,
                        location: Location(name: locationName))
                    
                    self.itemManager?.addItem(item)
                }
        } else {
            let item = ToDoItem(title: titleString,
                itemDescription: descriptionString,
                timestamp: date?.timeIntervalSince1970,
                location: nil)
            
            self.itemManager?.addItem(item)
            
        }
        
    }
}
