//
//  AllNumbersViewController.swift
//  NumberMemorizing
//
//  Created by Alexander on 4.03.23.
//

import UIKit

class AllNumbersViewController: UIViewController {
  
  lazy private var tableView: UITableView = {
    let tableView = UITableView(frame: view.frame, style: .plain)
    tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
     
    view.addSubview(tableView)
  }
}

// MARK: Table View Delegate Methods
extension AllNumbersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigationController?.pushViewController(DetailsViewController(), animated: true)
  }
}

// MARK: Table View Data Source Methods
extension AllNumbersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 20
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = "\(indexPath.row)"
    return cell
  }
}
