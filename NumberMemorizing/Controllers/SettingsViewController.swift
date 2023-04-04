//
//  SettingsViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.04.23.
//

import UIKit

class SettingsViewController: UIViewController {
  
  lazy private var restoreInitialNumbersButton: UIButton = {
    MyUI.configButton(target: self, action: #selector(restoreInitialNumbers), for: .touchUpInside)
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configView()
  }
  
  @objc func restoreInitialNumbers() {
    
  }
  
  private func configView() {
    view.backgroundColor = .white
    navigationItem.title = "Settings"
    
    view.addSubview(restoreInitialNumbersButton)
    
    restoreInitialNumbersButton.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      restoreInitialNumbersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      restoreInitialNumbersButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
