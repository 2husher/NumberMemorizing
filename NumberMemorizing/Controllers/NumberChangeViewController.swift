//
//  NumberChangeViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import UIKit

protocol NumberChangeViewDelegate {
  func updateView()
}

class NumberChangeViewController: UIViewController {
  
  var number: Number!
  var delegate: NumberChangeViewDelegate?
  
  lazy private var numberTextField: UITextField = {
    return MyUI.configTextField(placeholder: "Enter a new number")
  }()
  
  lazy private var lettersTextField: UITextField = {
    return MyUI.configTextField(placeholder: "Enter the letters")
  }()
  
  lazy private var wordTextField: UITextField = {
    return MyUI.configTextField(placeholder: "Enter the word")
  }()
  
  lazy private var stackView: UIStackView = {
    return MyUI.configStackView(arrangedSubviews: [numberTextField, lettersTextField, wordTextField, imageView])
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
    dismiss(animated: true)
  }
 
  @objc private func createNumber() {
    if !numberTextField.text!.isEmpty && !lettersTextField.text!.isEmpty && !wordTextField.text!.isEmpty {
      number.value = Int(numberTextField.text!)!
      number.letters = lettersTextField.text!
      number.word = wordTextField.text!
//      print(#function, number)
      delegate?.updateView()
    }
    dismiss(animated: true)
   }
}
