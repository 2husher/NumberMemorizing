//
//  DetailsViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.03.23.
//

import UIKit

protocol DetailsViewControllerDelegate {
  func detailsViewControllerChanged(item: Item)
}

class DetailsViewController: UIViewController {
  
  var item: Item!
  
  var delegate: DetailsViewControllerDelegate?
  
  lazy private var numberLabel: UILabel! = {
    MyUI.configLabel(text: String(item.numberValue))
  }()

  lazy private var lettersLabel: UILabel! = {
    MyUI.configLabel(text: item.letters)
  }()
 
  lazy private var wordLabel: UILabel! = {
    MyUI.configLabel(text: item.word)
  }()

  lazy private var imageView: UIImageView! = {
    MyUI.configImageView(image: item.picture ?? UIImage(named: "default"))
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
    changeVC.item = item
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
//    guard numberLabel != nil else { return }
//    guard lettersLabel != nil else { return }
//    guard wordLabel != nil else { return }
    
    numberLabel.text = String(item.numberValue)
    lettersLabel.text = item.letters
    wordLabel.text = item.word
    imageView.image = item.picture ?? UIImage(named: "default")
  }
}

extension DetailsViewController: NumberChangeViewControllerDelegate {
  func numberChangeViewControllerChanged(item: Item) {
    updateView()
    delegate?.detailsViewControllerChanged(item: item)
  }
}
