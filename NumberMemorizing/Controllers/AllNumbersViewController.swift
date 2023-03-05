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
  
  var numbers = [Number]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    for i in 1...20 {
      numbers.append(Number(value: i, letters: "ББ", word: "АББА"))
    }
     
    view.addSubview(tableView)
  }
}

// MARK: Table View Delegate Methods
extension AllNumbersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailsVC = DetailsViewController()
    detailsVC.number = numbers[indexPath.row]
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}

// MARK: Table View Data Source Methods
extension AllNumbersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numbers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyConstants.tableViewCellId, for: indexPath)
    let number = numbers[indexPath.row]
    cell.textLabel?.text = "\(number.value) - \(number.letters) - \(number.word)"
    return cell
  }
}
