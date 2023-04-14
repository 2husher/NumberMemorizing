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


  var numberStr = "" {
    didSet {
      dataPicker.reloadAllComponents()
    }
  }

  var label = UILabel()

  var letters = [[String]]()

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
    numberStr.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    2
  }
}

// MARK: - Picker Delegate Methods
extension EmbeddedDataPickerViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    numberStr.map { String($0) }[component]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    var output = ""
    for i in 0 ..< numberStr.count {
      let row = dataPicker.selectedRow(inComponent: i)
      output += numberStr.map { String($0) }[i]
    }
    print(output)
  }
}
