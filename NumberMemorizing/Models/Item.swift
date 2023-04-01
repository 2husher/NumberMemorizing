//
//  Item.swift
//  NumberMemorizing
//
//  Created by Alexander on 1.04.23.
//

import UIKit

class Item: NSObject {
  var number: Number
  var picture: UIImage?
  
  init(number: Number, picture: UIImage? = nil) {
    self.number = number
    self.picture = picture
  }
}
