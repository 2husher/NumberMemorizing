//
//  NumbersPool.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import Foundation

struct NumbersPool {
  private var numbers: [Number] = []
  
  var count: Int {
    return numbers.count
  }
  
  init() {
    for i in 1...20 {
      numbers.append(Number(value: i, letters: "ББ", word: "АББА"))
    }
  }
  
  func number(at index: Int) -> Number {
    return numbers[index]
  }
  
  mutating func removeNumber(_ number: Number) {
    let index = numbers.firstIndex(of: number)
    if let index = index {
      numbers.remove(at: index)
    }
  }
  
  mutating func moveNumber(from sourceIndex: Int, to destIndex: Int) {
    if sourceIndex == destIndex {
      return
    }
    
    let number = numbers[sourceIndex]
    numbers.remove(at: sourceIndex)
    numbers.insert(number, at: destIndex)
  }
}
