//
//  ItemStore.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import Foundation

class ItemStore {
  var items: [Item] = []
  
  func removeItem(_ item: Item) {
    let index = items.firstIndex(of: item)
    if let index = index {
      items.remove(at: index)
    }
  }
  
  func moveItem(from sourceIndex: Int, to destIndex: Int) {
    if sourceIndex == destIndex {
      return
    }
    
    let item = items[sourceIndex]
    items.remove(at: sourceIndex)
    items.insert(item, at: destIndex)
  }
  
  func addItem(_ item: Item) {
    items.append(item)
  }
  
  func save() {
    // FIXME:
  }
  
  func load() -> [Item] {
    // FIXME:
    return []
  }
}
