//
//  NumberChangeViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import UIKit

protocol NumberChangeViewControllerDelegate {
  func numberChangeViewControllerChanged(item: Item)
}

class NumberChangeViewController: UIViewController {
  
  var item: Item?
  var delegate: NumberChangeViewControllerDelegate?

  var childNumberViewController: EmbeddedNumberViewController!
  var childWordViewController: EmbeddedWordViewController!
  var childImageViewController: EmbeddedImageViewController!
  var childDataPickerViewController: EmbeddedDataPickerViewController!
  
  private var selectedPicture: UIImage?

  // TODO: scroll view for letters choices.
  lazy private var lettersLabel: UILabel! = {
    MyUI.configLabel(text: "LETTERS FOR NUMBER")
  }()

  lazy private var lettersTextField: UITextField = {
    let lettersTextField = MyUI.configTextField(placeholder: "Enter the letters")
    lettersTextField.delegate = self
    return lettersTextField
  }()
  
  lazy private var selectLettersButton: UIButton = {
    MyUI.configButton(title: "Select letters", target: self, action: #selector(selectLetters))
  }()
  
  private var stackView: UIStackView!
  
  lazy private var tapGestureRecognizer: UITapGestureRecognizer = {
    MyUI.configTapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
  }()
  
  private var textFields = [UITextField]()
  
  lazy private var myNavigationItem: UINavigationItem = {
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    if item == nil {
      navigationItem.title = "Create Number"
      navigationItem.rightBarButtonItem?.isEnabled = false
    }
    else {
      navigationItem.title = "Edit Number"
    }
    return navigationItem
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configView()
    configViewsConstraints()
  }
   
  
  // MARK: - Helper Methods
  @objc private func cancel() {
    view.endEditing(true)
    dismiss(animated: true)
  }
  
  private func configView() {
    if let item = item {
//      numberTextField.text = String(item.numberValue)
      lettersTextField.text = item.letters
//      childWordViewController.wordTextField.text = item.word
    }
    
//    textFields.append(numberTextField)
    textFields.append(lettersTextField)
//    textFields.append(childWordViewController.wordTextField)
    textFields.forEach { $0.clearButtonMode = .whileEditing }
    
    view.backgroundColor = .white
    
    view.addGestureRecognizer(tapGestureRecognizer)
    

    _ = myNavigationItem.title

    childWordViewController = EmbeddedWordViewController()
    childNumberViewController = EmbeddedNumberViewController()
    childImageViewController = EmbeddedImageViewController()
    childDataPickerViewController = EmbeddedDataPickerViewController()

    addChild(childWordViewController)
    addChild(childNumberViewController)
    addChild(childImageViewController)
    addChild(childDataPickerViewController)

    stackView =  MyUI.configStackView(arrangedSubviews: [
      childNumberViewController.view,
//      lettersLabel,
//      selectLettersButton,
      //      lettersTextField,
      childDataPickerViewController.view,
      childWordViewController.view,
      childImageViewController.view
    ])
    
    view.addSubview(stackView)

    childNumberViewController.didMove(toParent: self)
    childDataPickerViewController.didMove(toParent: self)
    childWordViewController.didMove(toParent: self)
    childImageViewController.didMove(toParent: self)
  }

  private func configViewsConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20)//,
//      stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 20)//,
//      childTableViewController.tableView.heightAnchor.constraint(equalTo: childImageViewController.imageView.heightAnchor)
    ])
  }

  @objc private func selectLetters() {

  }

  @objc private func done() {
    let numberText = childNumberViewController.numberTextField.text!
    let lettersText = lettersTextField.text!
    let wordText = childWordViewController.wordTextField.text!

    guard !numberText.isEmpty else { return }
    guard let numberValue = Int(numberText) else { return }
    guard !lettersText.isEmpty else { return }
    guard !wordText.isEmpty else { return }

    if let item = item {
      // FIXME: do I need to check each field whether it changed?
      item.numberValue = numberValue
      item.letters = lettersText
      item.word = wordText
      // TODO: Does item from box affect inside option?
    }
    else {
      item = Item(number: numberValue, letters: lettersText, word: wordText)
    }
    // TODO: implement hasPicture
    if selectedPicture != nil, let item = item {
      item.pictureID = Item.nextPictureID()
      item.picture = selectedPicture
    }
    delegate?.numberChangeViewControllerChanged(item: item!)
    view.endEditing(true)
    dismiss(animated: true)
   }
  
  @objc private func dismissKeyboard() {
//    stackView.arrangedSubviews.forEach { if $0.isFirstResponder { $0.resignFirstResponder() } }
    view.endEditing(true)
  }
}

// MARK: - TextField Delegate Methods
extension NumberChangeViewController: UITextFieldDelegate {  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

//    myNavigationItem.rightBarButtonItem?.isEnabled = allTextFieldsFilled(currentTextField: textField) && !newText.isEmpty
    return true
  }

  // MARK: - TextField Helper Methods



  private func allTextFieldsFilled(currentTextField: UITextField) -> Bool {
    for field in self.textFields {
      if currentTextField != field && field.text!.isEmpty {
        return false
      }
    }
    return true
  }
}

