//
//  DetailsViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.03.23.
//

import UIKit

class DetailsViewController: UIViewController {
  
  var number: Number!
  
  lazy private var numberLabel: UILabel = {
    return MyUI.configLabel(text: String(number.value))
  }()
  
  lazy private var lettersLabel: UILabel = {
    return MyUI.configLabel(text: number.letters)
  }()
  
  lazy private var wordLabel: UILabel = {
    return MyUI.configLabel(text: number.word)
  }()
  
  lazy private var imageView: UIImageView = {
    return MyUI.configImageView(imageName: "default")
  }()
  
  lazy private var stackView: UIStackView = {
    return MyUI.configStackView(arrangedSubviews: [numberLabel, lettersLabel, wordLabel, imageView])
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Details"
    view.backgroundColor = .white
    view.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
    ])
  }
}

extension DetailsViewController {

}
