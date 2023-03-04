//
//  AllNumbersViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.03.23.
//

import UIKit

class AllNumbersViewController: UIViewController {
  
  private var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
     
    view.backgroundColor = .green
    configureTableView()
  }
  
  private func configureTableView() {
    tableView = UITableView(frame: view.frame, style: .plain)
    tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.dataSource = self
    view.addSubview(tableView)
  }
}

// MARK: Table View Delegate Methods

// MARK: Table View Data Source Methods
extension AllNumbersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
}
