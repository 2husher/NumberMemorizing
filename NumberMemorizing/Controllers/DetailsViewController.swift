//
//  DetailsViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.03.23.
//

import UIKit

class DetailsViewController: UIViewController {
  
  lazy private var numberLabel: UILabel = {
    return MyUI.configLabel(text: "Number")
  }()
  
  lazy private var lettersLabel: UILabel = {
    return MyUI.configLabel(text: "Letters")
  }()
  
  lazy private var wordLabel: UILabel = {
    return MyUI.configLabel(text: "Word")
  }()
  
  lazy private var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [numberLabel, lettersLabel, wordLabel])
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 20
//    stackView.backgroundColor = .yellow
    return stackView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Details"
    view.backgroundColor = .white
    view.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
    ])
  }
}

extension DetailsViewController {

}
