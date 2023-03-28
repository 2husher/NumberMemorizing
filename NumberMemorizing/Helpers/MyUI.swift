//
//  MyUI.swift
//  NumberMemorizing
//
//  Created by Alexander on 5.03.23.
//

import UIKit

class MyUI {
  
  class func configLabel(text: String) -> UILabel {
    let label = UILabel(frame: CGRect.zero)
    label.textAlignment = .center
    label.font = UIFont.systemFont(ofSize: 20)
    label.text = text
    label.sizeToFit()
    //    label.backgroundColor = .green
    return label
  }
  
  class func configTextField(placeholder: String = "", text: String = "") -> UITextField {
    let textField = UITextField()
    textField.placeholder = placeholder
    textField.text = text
    textField.textAlignment = .center
    textField.borderStyle = .roundedRect
    return textField
  }
  
  class func configStackView(arrangedSubviews: [UIView]) -> UIStackView {
    let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .fill
    stackView.spacing = 20
    //    stackView.backgroundColor = .yellow
    return stackView
  }
  
  class func configImageView(imageName name: String) -> UIImageView {
    let image = UIImage(named: name)
    let imageView = UIImageView(image: image)
    imageView.backgroundColor = .red
    imageView.contentMode = .scaleAspectFit
    return imageView
  }
  
  class func configTapGestureRecognizer(target: Any?, action: Selector?) -> UITapGestureRecognizer {
    let tapGestureRecognizer = UITapGestureRecognizer(target: target, action: action)
    tapGestureRecognizer.numberOfTapsRequired = 1
    tapGestureRecognizer.numberOfTouchesRequired = 1
    return tapGestureRecognizer
  }
  
  class func configButton(target: Any?, action: Selector, for controlEvents: UIControl.Event) -> UIButton {
    let chooseImageButton = UIButton(type: .system)
    chooseImageButton.frame = CGRect.zero
    chooseImageButton.setTitle("Choose the image", for: .normal)
    chooseImageButton.sizeToFit()
    chooseImageButton.addTarget(target, action: action, for: controlEvents)
    return chooseImageButton
  }
}
