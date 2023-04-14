//
//  EmbeddedDataPickerViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 11.04.23.
//

import UIKit

class EmbeddedDataPickerViewController: UIViewController {

  private var dataPicker: UIPickerView!
  private var selectedLettersButton: UIButton!
  private var stackView: UIStackView!

  lazy private var lettersLabel: UILabel! = {
    MyUI.configLabel(text: "LETTERS FOR NUMBER")
  }()

  var label = UILabel()

  var letters = [[String]]()

  override func viewDidLoad() {
    super.viewDidLoad()

    configViews()
    configViewsConstraints()

//    view.backgroundColor = .yellow
    dataPicker.backgroundColor = .lightGray
//    lettersLabel.backgroundColor = .blue

    letters = [
      ["Г", "Ж"],
      ["Д", "Т"],
      ["К", "Х"],
      ["Г", "Ж"],
      ["Д", "Т"],
      ["К", "Х"],
      ["Д", "Т"],
      ["К", "Х"]
      ]

    dataPicker.delegate = self
    label.text = "HELLLLLO"
    label.sizeToFit()
    label.font = UIFont.systemFont(ofSize: 20)

  }

  private func configViews() {
    dataPicker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    selectedLettersButton = MyUI.configButton(title: "Select letters", target: self, action: #selector(pickLetters))

    var tmpButton: UIButton! = MyUI.configButton(title: "Select letters", target: self, action: #selector(pickLetters))
    stackView = MyUI.configStackView(arrangedSubviews: [dataPicker, selectedLettersButton, lettersLabel])
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
      dataPicker.heightAnchor.constraint(equalToConstant: 100)
    ])
    dataPicker.setContentHuggingPriority(UILayoutPriority(1000), for: .vertical)
    lettersLabel.setContentCompressionResistancePriority(UILayoutPriority(2222), for: .vertical)
  }

  @objc private func pickLetters() {
    print(#function)

    var output = ""
    for i in 0 ..< letters.count {
      let row = dataPicker.selectedRow(inComponent: i)
      output += letters[i][row]
    }
    print(output)
  }
}

// MARK: - Picker Data Source Methods
extension EmbeddedDataPickerViewController: UIPickerViewDataSource
{
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    letters.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    2
  }
}

// MARK: - Picker Delegate Methods
extension EmbeddedDataPickerViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//    letters[component][row]
    "1"
  }

//  func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
//    30
//  }
//
//  func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
//    30
//  }
}
