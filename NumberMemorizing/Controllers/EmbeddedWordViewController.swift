//
//  EmbeddedWordViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 7.04.23.
//

import UIKit

class EmbeddedWordViewController: UIViewController {

  var wordTextField: UITextField!
  private var wordLabel: UILabel!
  private var stackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()

    configViews()
    configViewsConstraints()
  }

  private func configViews() {
    wordLabel = MyUI.configLabel(text: "Word:")
    wordLabel.textAlignment = .justified

    wordTextField = MyUI.configTextField(placeholder: "Enter the word")
    wordTextField.delegate = self

    stackView = MyUI.configStackView(arrangedSubviews: [wordLabel, wordTextField])
    stackView.axis = .horizontal

    view.addSubview(stackView)
  }

  private func configViewsConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    let layoutGuide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: 0),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
      stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0)
      ])
  }
}

extension EmbeddedWordViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    true
  }
}
