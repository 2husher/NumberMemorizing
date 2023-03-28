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
}
