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
  
  private var selectedPicture: UIImage?

  lazy private var numberTextField: UITextField = {
    let numberTextField = MyUI.configTextField(placeholder: "Enter a new number")
    numberTextField.delegate = self
    numberTextField.tag = MyConstants.numberTextFieldTag
    return numberTextField
  }()

  // TODO: scroll view for letters choices.
  lazy private var lettersLabel: UILabel! = {
    MyUI.configLabel(text: "LETTERS FOR NUMBER")
  }()

  lazy private var lettersTextField: UITextField = {
    let lettersTextField = MyUI.configTextField(placeholder: "Enter the letters")
    lettersTextField.delegate = self
    return lettersTextField
  }()
  
  lazy private var wordTextField: UITextField = {
    let wordTextField = MyUI.configTextField(placeholder: "Enter the word")
    wordTextField.delegate = self
    return wordTextField
  }()
  
  lazy private var selectedPictureButton: UIButton = {
    MyUI.configButton(title: "Select a picture", target: self, action: #selector(pickPhoto))
  }()
  
  lazy private var stackView: UIStackView = {
    MyUI.configStackView(arrangedSubviews: [numberTextField, lettersLabel, lettersTextField, wordTextField, imageView, selectedPictureButton])
  }()
  
  lazy private var imageView: UIImageView = {
    MyUI.configImageView(image: item?.picture ?? UIImage(named: "default"))
  }()
  
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
  }
   
  
  // MARK: - Helper Methods
  @objc private func cancel() {
    view.endEditing(true)
    dismiss(animated: true)
  }
  
  private func configView() {
    if let item = item {
      numberTextField.text = String(item.numberValue)
      lettersTextField.text = item.letters
      wordTextField.text = item.word
    }
    
    textFields.append(numberTextField)
    textFields.append(lettersTextField)
    textFields.append(wordTextField)
    textFields.forEach { $0.clearButtonMode = .whileEditing }
    
    view.backgroundColor = .white
    
    view.addGestureRecognizer(tapGestureRecognizer)
    
        
    _ = myNavigationItem.title
    
    view.addSubview(stackView)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -20),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
    ])
  }
 
  @objc private func done() {
    let numberText = numberTextField.text!
    let lettersText = lettersTextField.text!
    let wordText = wordTextField.text!

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
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    myNavigationItem.rightBarButtonItem?.isEnabled = false
    return true
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let oldText = textField.text!
    let newText = oldText.replacingCharacters(in: Range(range, in: oldText)!, with: string)

    if isQuantityOfDigitsInNumberMoreThanLimit(textField: textField, text: newText) { return false }

    if !onlyDigitsEnteredForNumber(textField: textField, text: newText) { return false }

    if textField.tag == MyConstants.numberTextFieldTag {
      lettersLabel.text = newText
    }


    myNavigationItem.rightBarButtonItem?.isEnabled = allTextFieldsFilled(currentTextField: textField) && !newText.isEmpty
    return true
  }

  // MARK: - Helper Methods
  private func onlyDigitsEnteredForNumber(textField: UITextField, text: String) -> Bool {
    if textField.tag == MyConstants.numberTextFieldTag {
      return text.filter { $0.isNumber } == text
    }
    return true
  }

  private func isQuantityOfDigitsInNumberMoreThanLimit(textField: UITextField, text: String) -> Bool {
    let maxQuantityDigitsInNumber = 8
    if textField.tag == MyConstants.numberTextFieldTag, text.count > maxQuantityDigitsInNumber {
      return true
    }
    return false
  }

  private func allTextFieldsFilled(currentTextField: UITextField) -> Bool {
    for field in self.textFields {
      if currentTextField != field && field.text!.isEmpty {
        return false
      }
    }
    return true
  }
}

extension NumberChangeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  // MARK: - Image Helper Methods
  private func takePhotoWithCamera() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .camera
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true)
  }
  
  private func choosePhotoFromLibrary() {
    let imagePicker = UIImagePickerController()
    imagePicker.sourceType = .photoLibrary
    imagePicker.delegate = self
    imagePicker.allowsEditing = true
    present(imagePicker, animated: true)
  }
  
  @objc private func pickPhoto() {
    if UIImagePickerController.isSourceTypeAvailable(.camera) {
      showPhotoMenu()
    }
    else {
      choosePhotoFromLibrary()
    }
  }
  
  private func showPhotoMenu() {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
    
    let actCancel = UIAlertAction(title: "Cancel", style: .cancel)
    alert.addAction(actCancel)
    
    let actPhoto = UIAlertAction(title: "Take photo", style: .default) { _ in
      self.takePhotoWithCamera()
    }
    alert.addAction(actPhoto)
    
    let actLibrary = UIAlertAction(title: "Choose from library", style: .default) { _ in
      self.choosePhotoFromLibrary()
    }
    alert.addAction(actLibrary)
    
    present(alert, animated: true)
  }
  
  // MARK: - Image Picker Delegate Methods
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    selectedPicture = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
    imageView.image = selectedPicture
    dismiss(animated: true)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
}
