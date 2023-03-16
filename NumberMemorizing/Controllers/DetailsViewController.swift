//
//  DetailsViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.03.23.
//

import UIKit

class DetailsViewController: UIViewController {
  
  var number: Number! {
    didSet {
      updateView()
    }
  }

  lazy private var numberLabel: UILabel! = {
    MyUI.configLabel(text: String(number.value))
  }()

  lazy private var lettersLabel: UILabel! = {
    MyUI.configLabel(text: number.letters)
  }()
 
  lazy private var wordLabel: UILabel! = {
    MyUI.configLabel(text: number.word)
  }()

  lazy private var imageView: UIImageView! = {
    MyUI.configImageView(imageName: "default")
  }()

  lazy private var stackView: UIStackView! = {
     MyUI.configStackView(arrangedSubviews: [numberLabel, lettersLabel, wordLabel, imageView])
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Details"
    view.backgroundColor = .white
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editNumber))

    configView()
    updateView()
  }
  
  // MARK: - Helper Methods
  @objc private func editNumber() {
    let changeVC = NumberChangeViewController()
    let changeNavC = UINavigationController(rootViewController: changeVC)
    changeVC.number = number
    changeVC.delegate = self
    present(changeNavC, animated: true)
    changeVC.modalPresentationStyle = .fullScreen
  }
  
  func configView() {
    view.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
    ])
  }
  
  func updateView() {
    guard numberLabel != nil else { return }
    guard lettersLabel != nil else { return }
    guard wordLabel != nil else { return }
    
    numberLabel.text = String(number.value)
    lettersLabel.text = number.letters
    wordLabel.text = number.word
  }
}

extension DetailsViewController: NumberChangeViewDelegate {
  func update(number: Number) {
    self.number = number    
  }
}
