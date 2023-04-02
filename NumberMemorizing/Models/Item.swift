//
//  Item.swift
//  NumberMemorizing
//
//  Created by Alexander on 5.03.23.
//

import UIKit

class Item: NSObject {
  var numberValue: Int
  var letters: String
  var word: String
  var pictureID: Int?
  var picture: UIImage?
  
  var hasPicture: Bool {
    pictureID != nil
  }
  
  var pictureURL: URL {
    assert(pictureID != nil, "No photo ID set")
    let filename = "Photo-\(pictureID!).jpg"
    return MyIO.documentDirectory().appending(component: filename)
  }
  
  init(number: Int, letters: String, word: String, pictureID: Int? = nil) {
    self.numberValue = number
    self.letters = letters
    self.word = word
    self.pictureID = pictureID
  }
  
  class func nextPictureID() -> Int {
    let userDefaults = UserDefaults.standard
    let currentID = userDefaults.integer(forKey: "PictureID") + 1
    userDefaults.set(currentID, forKey: "PictureID")
    return currentID
  }
}
