//
//  NumberChangeViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 8.03.23.
//

import UIKit

protocol NumberChangeViewDelegate {
  func update(number: Number, image: UIImage?)
}

class NumberChangeViewController: UIViewController {
  
  var number: Number?
  var delegate: NumberChangeViewDelegate?
  
  var image: UIImage?
  
  lazy private var numberTextField: UITextField = {
    let numberTextField = MyUI.configTextField(placeholder: "Enter a new number")
    numberTextField.delegate = self
    return numberTextField
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
  
  lazy private var chooseImageButton: UIButton = {
    MyUI.configButton(target: self, action: #selector(pickPhoto), for: .touchUpInside)
  }()
  
  lazy private var stackView: UIStackView = {
    MyUI.configStackView(arrangedSubviews: [numberTextField, lettersTextField, wordTextField, imageView, chooseImageButton])
  }()
  
  lazy private var imageView: UIImageView = {
    MyUI.configImageView(imageName: "default")
  }()
  
  lazy private var tapGestureRecognizer: UITapGestureRecognizer = {
    MyUI.configTapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
  }()
  
  var textFields = [UITextField]()
  
  lazy private var myNavigationItem: UINavigationItem = {
    if number == nil {
      navigationItem.title = "Create Number"
    }
    else {
      navigationItem.title = "Edit Number"
    }
    navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(changeNumber))
    navigationItem.rightBarButtonItem?.isEnabled = false
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
    if let number = number {
      numberTextField.text = String(number.value)
      lettersTextField.text = number.letters
      wordTextField.text = number.word
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
    if let image = image {
      if !number!.hasPicture {
        number!.pictureID = Number.nextPictureID()
      }
    }
    
    delegate?.update(number: number!, image: image)
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
    let allTextFieldFilled = { () -> Bool in
      for field in self.textFields {
        if textField != field && field.text!.isEmpty {
          return false
        }
      }
      return true
    }
    myNavigationItem.rightBarButtonItem?.isEnabled = allTextFieldFilled() && !newText.isEmpty
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
    image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
    imageView.image = image
    dismiss(animated: true)
  }
  
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
}
