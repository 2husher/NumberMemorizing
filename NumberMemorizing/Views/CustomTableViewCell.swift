//
//  CustomTableViewCell.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.03.23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
  
  lazy var numberLabel: UILabel! = {
    MyUI.configLabel(text: "Number")
  }()

  lazy var wordLabel: UILabel! = {
    MyUI.configLabel(text: "Word")
  }()
 
  lazy var customImageView: UIImageView = {
    let imageView = MyUI.configImageView(imageName: "default")
    return imageView
  }()
  
  lazy private var stackView: UIStackView = {
    var innerStack = MyUI.configStackView(arrangedSubviews: [numberLabel, wordLabel])
    innerStack.axis = .horizontal
    innerStack.distribution = .fill
//    numberLabel.backgroundColor = .red
//    wordLabel.backgroundColor = .green
    wordLabel.textAlignment = .right
//    innerStack.backgroundColor = .red
    var outerStack = MyUI.configStackView(arrangedSubviews: [customImageView, innerStack])
    outerStack.axis = .horizontal
//    outerStack.backgroundColor = .blue
    return outerStack
  }()
  
//  override func awakeFromNib() {
//    super.awakeFromNib()
//    // Initialization code
//
//  }
//
//  override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//
//    // Configure the view for the selected state
//  }
//
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    configView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helper Methods
  func configView() {
    addSubview(stackView)

    stackView.translatesAutoresizingMaskIntoConstraints = false
    numberLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5),
      stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor, constant: 20),
      stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor, constant: -20),
      customImageView.widthAnchor.constraint(equalTo: customImageView.heightAnchor),
      customImageView.widthAnchor.constraint(equalToConstant: MyConstants.tableViewRowHeight - 5 * 2)
    ])
  }
}
