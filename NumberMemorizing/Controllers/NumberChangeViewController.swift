//
//  NumberChangeViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import UIKit

class NumberChangeViewController: UIViewController {
  
  var number: Number!
  
  lazy private var numberLabel: UILabel = {
    return MyUI.configLabel(text: "Number")
  }()
  
  lazy private var stackView: UIStackView = {
    return MyUI.configStackView(arrangedSubviews: [numberLabel, imageView])
  }()
  
  lazy private var imageView: UIImageView = {
    return MyUI.configImageView(imageName: "default")
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    navigationItem.title = "Create Number"
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(createNumber))
    
    view.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
    ])
  }
  
  // MARK: - Helper Methods
  @objc private func cancel() {
    print(#function)
  }
 
  @objc private func createNumber() {
    print(#function)
   }
}
