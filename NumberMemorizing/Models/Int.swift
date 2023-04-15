//
//  Int.swift
//  NumberMemorizing
//
//  Created by Alexander on 15.04.23.
//

import Foundation

extension Int {
  var firstLetters: [String] {
    DigitsLettersMapping.letters(for: self, ordinal: .first)
  }

  var secondLetters: [String] {
    DigitsLettersMapping.letters(for: self, ordinal: .second)
  }

  var len: Int {
    String(self).count
  }
}
