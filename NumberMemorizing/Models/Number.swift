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
  var pictureID: Int?
  
  var hasPicture: Bool {
    pictureID != nil
  }
  
  var pictureURL: URL {
    assert(pictureID != nil, "No photo ID set")
    let filename = "Photo-\(pictureID!).jpg"
    return MyIO.documentDirectory().appending(component: filename)
  }
  
  init(value: Int, letters: String, word: String) {
    self.value = value
    self.letters = letters
    self.word = word
  }
  
  convenience init() {
    self.init(value: 0, letters: "", word: "")
  }
  
  class func nextPictureID() -> Int {
    let userDefaults = UserDefaults.standard
    let currentID = userDefaults.integer(forKey: "PictureID") + 1
    userDefaults.set(currentID, forKey: "PictureID")
    return currentID
  }
}
