//
//  DigitsLettersMapping.swift
//  NumberMemorizing
//
//  Created by Alexander on 5.04.23.
//

import Foundation

class DigitsLettersMapping {
  typealias LettersPair = (first: String, second: String)

  enum LetterOrdinal {
    case first
    case second
  }

  static private var lettersForDigits: [LettersPair] = [
    ("Н", "М"), ("Г", "Ж"), ("Д", "Т"), ("К", "Х"), ("Ч", "Щ"),
    ("П", "Б"), ("Ш", "Л"), ("С", "З"), ("В", "Ф"), ("Р", "Ц")
  ]

  /*func number(for letter: String) -> String {
    let letterUpcased = letter.uppercased()
    for (index, lettersPair) in privateDigits.enumerated() {

      if letterUpcased == lettersPair.first || letterUpcased == lettersPair.second {
        return String(index)
      }
    }
    return ""
  } */

  static func letter(for digit: Int, ordinal: DigitsLettersMapping.LetterOrdinal) -> String {
    guard digit >= 0 && digit <= 9 else { return "" }

    let lettersPair = lettersForDigits[digit]
    switch ordinal {
    case .first:
      return lettersPair.first
    case .second:
      return lettersPair.second
    }
  }

  static func letters(for number: Int, ordinal: DigitsLettersMapping.LetterOrdinal) -> [String] {
    guard number >= 0 else { return [] }

    var letters = [String]()
    let digitsFromNumber = String(number).map { Int(String($0))! }
    for digit in digitsFromNumber {
      let letter = letter(for: digit, ordinal: ordinal)
      letters.append(letter)
    }
    return letters
  }
}
