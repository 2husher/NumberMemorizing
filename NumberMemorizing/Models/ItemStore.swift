//
//  ItemStore.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import UIKit

class ItemStore {
  struct Number: Codable {
    var numberValue: Int
    var letters: String
    var word: String
    var pictureID: Int?
  }
  
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
  
  func saveItems() {
    var numbers = [Number]()
    for item in items {
      let number = Number(numberValue: item.numberValue, letters: item.letters, word: item.word, pictureID: item.pictureID)
      numbers.append(number)
    }
    saveNumbers(numbers)
    // FIXME: save picture
  }
  
  func loadItems() -> [Item] {
    let numbers = loadNumbers()
    for number in numbers {
      items.append(Item(number: number.numberValue, letters: number.letters, word: number.word))
    }
    // FIXME: load pictures
    return items
  }
  
  // MARK: - Helper Methods
  private func saveNumbers(_ numbers: [Number]) {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(numbers)
      try data.write(to: MyIO.dataFilePath(), options: Data.WritingOptions.atomic)
    }
    catch {
      print("Error encoding numbers array: \(error.localizedDescription)")
    }
  }
  
  private func loadNumbers() -> [Number]{
    var numbers: [Number] = []
    let decoder = PropertyListDecoder()
    do {
      let data = try Data(contentsOf: MyIO.dataFilePath())
      numbers = try decoder.decode([Number].self, from: data)
    }
    catch {
      print("Error decoding numbers array: \(error.localizedDescription)")
    }
    return numbers
  }
}
