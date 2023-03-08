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
    tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: MyConstants.tableViewCellId)
    tableView.dataSource = self
    tableView.delegate = self
    return tableView
  }()
  
  var numbersPool = NumbersPool()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
    
    navigationItem.title = "Numbers"
    navigationItem.leftBarButtonItem = editButtonItem
  }
  
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    tableView.setEditing(editing, animated: animated)
  }
}

// MARK: Table View Delegate Methods
extension AllNumbersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailsVC = DetailsViewController()
    detailsVC.number = numbersPool.number(at: indexPath.row)
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}

// MARK: Table View Data Source Methods
extension AllNumbersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numbersPool.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyConstants.tableViewCellId, for: indexPath)
    let number = numbersPool.number(at: indexPath.row)
    cell.textLabel?.text = "\(number.value) - \(number.letters) - \(number.word)"
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let number = numbersPool.number(at: indexPath.row)
      numbersPool.removeNumber(number)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    numbersPool.moveNumber(from: sourceIndexPath.row, to: destinationIndexPath.row)
  }
}
