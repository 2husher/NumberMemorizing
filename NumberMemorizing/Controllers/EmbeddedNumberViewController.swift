//
//  EmbeddedNumberViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 7.04.23.
//

import UIKit

class EmbeddedNumberViewController: UIViewController {
  var numberTextField: UITextField!
  private var numberLabel: UILabel!
  private var stackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()

    configViews()
    configViewsConstraints()
  }

  private func configViews() {
    numberLabel = MyUI.configLabel(text: "Number:")
    numberLabel.textAlignment = .justified

    numberTextField = MyUI.configTextField(placeholder: "Enter the number")
    numberTextField.delegate = self
    numberTextField.tag = MyConstants.numberTextFieldTag

    stackView = MyUI.configStackView(arrangedSubviews: [numberLabel, numberTextField])
    stackView.axis = .horizontal

    view.addSubview(stackView)
  }

  private func configViewsConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
      stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0)
    ])
    numberLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
  }
}

// MARK: - TextField Delegate Methods
extension EmbeddedNumberViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }

  func textFieldShouldClear(_ textField: UITextField) -> Bool {
//    myNavigationItem.rightBarButtonItem?.isEnabled = false
    return true
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    let newText = oldText.replacingCharacters(in: Range(range, in: oldText)!, with: string)

    if !onlyDigitsEnteredForNumber(number: newText) { return false }

    if isQuantityOfDigitsInNumberMoreThanLimit(number: newText) { return false }

    return true
  }

  // MARK: - Text Field Helper Methods
  private func isQuantityOfDigitsInNumberMoreThanLimit(number: String) -> Bool {
    let maxQuantityDigitsInNumber = 8
    return number.count > maxQuantityDigitsInNumber ? true : false
  }

  private func onlyDigitsEnteredForNumber(number: String) -> Bool {
    number.filter { $0.isNumber } == number
  }
}
