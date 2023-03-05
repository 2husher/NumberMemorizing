//
//  MyUI.swift
//  NumberMemorizing
//
//  Created by Alexander on 5.03.23.
//

import UIKit

class MyUI {
  
  class func configLabel(text: String) -> UILabel {
    let label = UILabel(frame: CGRect.zero)
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 20)
    label.text = text
    label.sizeToFit()
    //    label.backgroundColor = .green
    return label
  }
}
