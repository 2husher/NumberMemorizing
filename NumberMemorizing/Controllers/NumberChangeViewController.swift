//
//  NumberChangeViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import UIKit

protocol NumberChangeViewDelegate {
  func update(number: Number)
}

class NumberChangeViewController: UIViewController {
  
  var number: Number?
  var delegate: NumberChangeViewDelegate?
  
  lazy private var numberTextField: UITextField = {
    MyUI.configTextField(placeholder: "Enter a new number")
  }()
  
  lazy private var lettersTextField: UITextField = {
    MyUI.configTextField(placeholder: "Enter the letters")
  }()
  
  lazy private var wordTextField: UITextField = {
    MyUI.configTextField(placeholder: "Enter the word")
  }()
  
  lazy private var stackView: UIStackView = {
    MyUI.configStackView(arrangedSubviews: [numberTextField, lettersTextField, wordTextField, imageView])
  }()
  
  lazy private var imageView: UIImageView = {
    MyUI.configImageView(imageName: "default")
  }()
  
  lazy private var tapGestureRecognizer: UITapGestureRecognizer = {
    MyUI.configTapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configView()
  }
   
  
  // MARK: - Helper Methods
  @objc private func cancel() {
    dismiss(animated: true)
  }
  
  private func configView() {
    if let number = number {
      numberTextField.text = String(number.value)
      lettersTextField.text = number.letters
      wordTextField.text = number.word
    }
    
    view.backgroundColor = .white
    
    view.addGestureRecognizer(tapGestureRecognizer)
    
    if number == nil {
      navigationItem.title = "Create Number"
    }
    else {
      navigationItem.title = "Edit Number"
    }
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(changeNumber))
    
    view.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
    ])
  }
 
  @objc private func changeNumber() {
    let numberText = numberTextField.text!
    let lettersText = lettersTextField.text!
    let wordText = wordTextField.text!
    
    guard !numberText.isEmpty else { return }
    guard let numberValue = Int(numberText) else { return }
    guard !lettersText.isEmpty else { return }
    guard !wordText.isEmpty else { return }
    
    if number != nil {
      number!.value = numberValue
      number!.letters = lettersText
      number!.word = wordText
    }
    else {
      number = Number(value: numberValue, letters: lettersText, word: wordText)
    }
    delegate?.update(number: number!)
    dismiss(animated: true)
   }
  
  @objc private func dismissKeyboard() {
    print(#function)
  }
}
