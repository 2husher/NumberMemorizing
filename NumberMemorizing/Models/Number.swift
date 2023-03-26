//
//  Number.swift
//  NumberMemorizing
//
//  Created by Alexander on 5.03.23.
//

import Foundation

class Number: Equatable, Codable {
  static func == (lhs: Number, rhs: Number) -> Bool {
    lhs.value == rhs.value
  }
  
  var value: Int
  var letters: String
  var word: String
  
  init(value: Int, letters: String, word: String) {
    self.value = value
    self.letters = letters
    self.word = word
  }
  
  convenience init() {
    self.init(value: 0, letters: "", word: "")
  }
}
