//
//  MyIO.swift
//  NumberMemorizing
//
//  Created by Alexander on 28.03.23.
//

import Foundation

class MyIO {
  class func documentDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  class func dataFilePath() -> URL{
    documentDirectory().appending(component: "Numbers.plist")
  }
  
  class func saveNumbers(_ numbers: [Number]) {
    let encoder = PropertyListEncoder()
    do {
      let data = try encoder.encode(numbers)
      try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
    }
    catch {
      print("Error encoding numbers array: \(error.localizedDescription)")
    }
  }
  
  class func loadNumbers() -> [Number]{
    var numbers: [Number] = []
    let decoder = PropertyListDecoder()
    do {
      let data = try Data(contentsOf: dataFilePath())
      numbers = try decoder.decode([Number].self, from: data)
    }
    catch {
      print("Error decoding numbers array: \(error.localizedDescription)")
    }
    return numbers
  }
}
