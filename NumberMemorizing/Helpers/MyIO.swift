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
  
  class func resetNumbersPlist() {
    do {
      let fromUrl = Bundle.main.url(forResource: "InitialNumbers", withExtension: "plist")!
      let data = try Data(contentsOf: fromUrl)
      try data.write(to: dataFilePath(), options: .atomic)
    }
    catch {
      print((error as NSError).description)
    }
  }
}
