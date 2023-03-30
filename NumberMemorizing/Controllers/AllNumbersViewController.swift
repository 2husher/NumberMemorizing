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
  var number: Number?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
    
    navigationItem.title = "Numbers"
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewNumber))
    
    tableView.rowHeight = MyConstants.tableViewRowHeight
    
    numbersPool.numbers = MyIO.loadNumbers()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tableView.reloadData()
  }
  
  // MARK: - Helper Methods
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    tableView.setEditing(editing, animated: animated)
  }
  
  @objc private func createNewNumber() {
    let changeVC = NumberChangeViewController()
    let changeNavC = UINavigationController(rootViewController: changeVC)
    changeVC.number = number
    changeVC.delegate = self
    present(changeNavC, animated: true)
  }
}

// MARK: Table View Delegate Methods
extension AllNumbersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailsVC = DetailsViewController()
    detailsVC.number = numbersPool.number(at: indexPath.row)
    detailsVC.image = (tableView.cellForRow(at: indexPath) as? CustomTableViewCell)?.customImageView.image
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}

// MARK: Table View Data Source Methods
extension AllNumbersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return numbersPool.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyConstants.tableViewCellId, for: indexPath) as! CustomTableViewCell
    let number = numbersPool.number(at: indexPath.row)
    cell.numberLabel.text = String(number.value)
    cell.wordLabel.text = String(number.word)
    if number.hasPicture {
      cell.customImageView.image = UIImage(contentsOfFile: number.pictureURL.path())
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let number = numbersPool.number(at: indexPath.row)
      
      let alertController = {
        let title = "Delete \(number.value)"
        let message = "Are you sure you want to delete this number?"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
          self.numbersPool.removeNumber(number)
          self.tableView.deleteRows(at: [indexPath], with: .automatic)
          MyIO.saveNumbers(self.numbersPool.numbers)
        })
        ac.addAction(deleteAction)
        return ac
      }()
      present(alertController, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    numbersPool.moveNumber(from: sourceIndexPath.row, to: destinationIndexPath.row)
    MyIO.saveNumbers(numbersPool.numbers)
  }
  
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    "Remove"
  }
}

// MARK: - Number Change View Delegate Methods
extension AllNumbersViewController: NumberChangeViewDelegate {
  func update(number: Number, image: UIImage?) {    
    numbersPool.addNumber(number)
    tableView.reloadData()
    MyIO.saveNumbers(numbersPool.numbers)
    if let picture = image {
      savePicture(picture, to: number.pictureURL)
    }
  }
  
  func savePicture(_ picture: UIImage, to pictureURL: URL ) {
    if let data = picture.jpegData(compressionQuality: 0.5) {
      do {
        try data.write(to: pictureURL, options: .atomic)
      }
      catch {
        print("Error writing file: \(error)")
      }
    }
  }
}
