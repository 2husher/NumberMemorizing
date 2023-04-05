//
//  DigitsLettersStore.swift
//  NumberMemorizing
//
//  Created by Alexander on 5.04.23.
//

import Foundation

class DigitsLettersMapping {
  enum LetterOrdinal {
    case first
    case second
  }

  private var privateDigits: [(first: String, second: String)] =
    [("Н","М"),("Г","Ж"),("Д","Т"),("К","Х"),("Ч","Щ"),("П","Б"),("Ш","Л"),("С","З"),("В","Ф"),("Р","Ц")]

  func number(for letter: String) -> String {
    let letterUpcased = letter.uppercased()
    for (index, lettersPair) in privateDigits.enumerated() {

      if letterUpcased == lettersPair.first || letterUpcased == lettersPair.second {
        return String(index)
      }
    }
    return ""
  }

  func letter(for number: Int, ordinal: DigitsLettersMapping.LetterOrdinal) -> String {
    let lettersPair = privateDigits[number]
    switch ordinal {
    case .first: return lettersPair.first
    case .second: return lettersPair.second
    }
  }
}
