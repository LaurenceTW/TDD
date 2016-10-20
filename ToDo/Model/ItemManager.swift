//
//  ItemManager.swift
//  ToDo
//
//  Created by dasdom on 27.09.15.
//  Copyright © 2015 Dominik Hauser. All rights reserved.
//

import Foundation

class ItemManager {
    var toDoCount: Int { return toDoItems.count }
    var doneCount: Int { return doneItems.count }
    private var toDoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    
    func addItem(item: ToDoItem) {
        if !toDoItems.contains(item) {
            toDoItems.append(item)
        }
    }
    
    func checkItemAtIndex(index: Int) {
//        guard index < toDoCount else { return }
//        
        let item = toDoItems.removeAtIndex(index)
        doneItems.append(item)
    }
    
    func itemAtIndex(index: Int) -> ToDoItem {
        return toDoItems[index]
    }
    
    func doneItemAtIndex(index: Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func removeAllItems() {
        toDoItems.removeAll()
        doneItems.removeAll()
    }
}