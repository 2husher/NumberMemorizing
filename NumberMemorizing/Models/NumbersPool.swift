//
//  NumbersPool.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import Foundation

class NumbersPool {
  var numbers: [Number] = []
  
  var count: Int {
    return numbers.count
  }

  func number(at index: Int) -> Number {
    return numbers[index]
  }
  
  func removeNumber(_ number: Number) {
    let index = numbers.firstIndex(of: number)
    if let index = index {
      numbers.remove(at: index)
    }
  }
  
  func moveNumber(from sourceIndex: Int, to destIndex: Int) {
    if sourceIndex == destIndex {
      return
    }
    
    let number = numbers[sourceIndex]
    numbers.remove(at: sourceIndex)
    numbers.insert(number, at: destIndex)
  }
  
  func addNumber(_ number: Number) {
    numbers.append(number)
  }
}
