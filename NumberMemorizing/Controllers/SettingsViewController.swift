//
//  SettingsViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.04.23.
//

import UIKit

class SettingsViewController: UIViewController {
  
  lazy private var restoreInitialNumbersButton: UIButton = {
    MyUI.configButton(title: "Restore initial numbers", target: self, action: #selector(restoreInitialNumbers))
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    configView()
  }
  
  @objc private func restoreInitialNumbers() {

    let alertController = {
      let title = "Reset Numbers Plist"
      let message = "Are you sure you want to reset numbers plist?"
      let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)

      let cancelAction = UIAlertAction(title: "No", style: .cancel)
      ac.addAction(cancelAction)

      let resetAction = UIAlertAction(title: "Yes", style: .destructive, handler: { (action) -> Void in
        let userDefaults = UserDefaults.standard
        let resetNumberPlist = true
        userDefaults.set(resetNumberPlist, forKey: MyConstants.resetNumbersPlist)
        MyIO.resetNumbersPlist()
      })
      ac.addAction(resetAction)
      return ac
    }()
    present(alertController, animated: true)
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
