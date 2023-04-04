//
//  ItemStore.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import UIKit

class ItemStore {
  private struct Number: Codable {
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
  
  func moveItem(from sourceIndex: Int, to destIndex: Int) -> Item? {
    if sourceIndex != destIndex {
      let item = items[sourceIndex]
      items.remove(at: sourceIndex)
      items.insert(item, at: destIndex)
      return item
    }
    else {
      return nil
    }
  }
  
  func addItem(_ item: Item) {
    items.append(item)
  }
  
  func saveItem(_ item: Item) {
    var numbers = [Number]()
    for item in items {
      let number = Number(numberValue: item.numberValue, letters: item.letters, word: item.word, pictureID: item.pictureID)
      numbers.append(number)
    }
    saveNumbers(numbers)
    if let picture = item.picture {
      savePicture(picture, to: item.pictureURL)
    }
  }
  
  func loadItems() -> [Item] {
    let numbers = loadNumbers()
    for number in numbers {
      let item = Item(number: number.numberValue, letters: number.letters, word: number.word, pictureID: number.pictureID)
      if number.pictureID != nil {
        item.picture = loadPicture(from: item.pictureURL)
      }
      items.append(item)
    }
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

  private func savePicture(_ picture: UIImage, to pictureURL: URL ) {
    if let data = picture.jpegData(compressionQuality: 0.5) {
      do {
        try data.write(to: pictureURL, options: .atomic)
      }
      catch {
        print("Error writing file: \(error)")
      }
    }
  }
  
  private func loadPicture(from pictureURL: URL) -> UIImage? {
    UIImage(contentsOfFile: pictureURL.path())
  }
}
