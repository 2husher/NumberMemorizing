//
//  EmbeddedImageViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 7.04.23.
//

import UIKit

class EmbeddedImageViewController: UIViewController {

  var imageView: UIImageView!
  private var selectedPictureButton: UIButton!
  private var stackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()

    configViews()
    configViewsConstraints()
  }

  private func configViews() {
    imageView = MyUI.configImageView(image: UIImage(named: "default"))
    selectedPictureButton = MyUI.configButton(title: "Select a picture", target: self, action: #selector(pickPhoto))

    stackView = MyUI.configStackView(arrangedSubviews: [imageView, selectedPictureButton])
    stackView.axis = .vertical

    view.addSubview(stackView)
  }

  private func configViewsConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
      stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0),
      imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
    ])
  }
}

extension EmbeddedImageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    imageView.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
    dismiss(animated: true)
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true)
  }
}
