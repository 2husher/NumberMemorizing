//
//  EmbeddedTableViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 7.04.23.
//

import UIKit

class EmbeddedTableViewController: UIViewController {

  private var combinations: [String]? {
    didSet {
      tableView.reloadData()
    }
  }

  var tableView: UITableView!
  private var stackView: UIStackView!

  override func viewDidLoad() {
    super.viewDidLoad()
    configViews()
    configViewsConstraints()

    combinations = ["One", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]


  }

  private func configViews() {
    tableView = UITableView(frame: .zero, style: .plain)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: MyConstants.embeddedTableViewCellId)
    tableView.dataSource = self
    tableView.rowHeight = MyConstants.embeddedTableViewRowHeight

    stackView = MyUI.configStackView(arrangedSubviews: [tableView])
    stackView.axis = .vertical

    view.addSubview(stackView)
  }

  private func configViewsConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
      stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 0),
      stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: 0),
      stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0)
    ])
  }
}

// MARK: Table View Data Source Methods
extension EmbeddedTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return combinations?.count ?? 0
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyConstants.embeddedTableViewCellId, for: indexPath)
    cell.textLabel?.text = combinations?[indexPath.row]
    return cell
  }
}
