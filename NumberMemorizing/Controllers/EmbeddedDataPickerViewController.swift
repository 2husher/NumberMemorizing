//
//  EmbeddedDataPickerViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 11.04.23.
//

import UIKit

class EmbeddedDataPickerViewController: UIViewController {

  private var dataPicker: UIPickerView!
  private var stackView: UIStackView!

  lazy private var lettersLabel: UILabel! = {
    MyUI.configLabel(text: "Letters for the number")
  }()

  var numberValue: Int? {
    didSet {
      selectedLetters = numberValue?.firstLetters ?? []
      dataPicker.reloadAllComponents()
    }
  }

  var selectedLetters: [String] = [] 

  var label = UILabel()

  override func viewDidLoad() {
    super.viewDidLoad()

    configViews()
    configViewsConstraints()

    dataPicker.delegate = self
  }

  private func configViews() {
    dataPicker = MyUI.configDataPicker()

    stackView = MyUI.configStackView(arrangedSubviews: [lettersLabel, dataPicker])
    stackView.axis = .vertical

    view.addSubview(stackView)
  }

  private func configViewsConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -0),
      stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -0),
      dataPicker.heightAnchor.constraint(equalToConstant: 80)
    ])
  }
}

// MARK: - Picker Data Source Methods
extension EmbeddedDataPickerViewController: UIPickerViewDataSource
{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    guard let numberValue = numberValue else { return 0 }
    return numberValue.len
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    2
  }
}

// MARK: - Picker Delegate Methods
extension EmbeddedDataPickerViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    guard let numberValue = numberValue else { return nil }
    switch row {
    case 0:
      return numberValue.firstLetters[component]
    case 1:
      return numberValue.secondLetters[component]
    default:
      fatalError("Wrong case variant.")
    }
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    guard let numberValue = numberValue else { return }
    selectedLetters.removeAll()
    for i in 0 ..< numberValue.len {
      let row = dataPicker.selectedRow(inComponent: i)
      switch row {
      case 0:
        selectedLetters.append(numberValue.firstLetters[i])
      case 1:
        selectedLetters.append(numberValue.secondLetters[i])
      default:
        fatalError("Wrong case variant.")
      }
    }
    print(selectedLetters.joined())
  }
}
