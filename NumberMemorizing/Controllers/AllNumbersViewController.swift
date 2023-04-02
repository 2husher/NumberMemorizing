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
  
  var itemStore = ItemStore()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(tableView)
    
    navigationItem.title = "Numbers"
    navigationItem.leftBarButtonItem = editButtonItem
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewItem))
    
    tableView.rowHeight = MyConstants.tableViewRowHeight
    
    _ = itemStore.loadItems()
  }
   
  // MARK: - Helper Methods
  override func setEditing(_ editing: Bool, animated: Bool) {
    super.setEditing(editing, animated: animated)
    tableView.setEditing(editing, animated: animated)
  }
  
  @objc private func createNewItem() {
    let changeVC = NumberChangeViewController()
    let changeNavC = UINavigationController(rootViewController: changeVC)
    changeVC.item = nil
    changeVC.delegate = self
    present(changeNavC, animated: true)
  }
}

// MARK: Table View Delegate Methods
extension AllNumbersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailsVC = DetailsViewController()
    detailsVC.item = itemStore.items[indexPath.row]
    detailsVC.delegate = self
    navigationController?.pushViewController(detailsVC, animated: true)
  }
}

// MARK: Table View Data Source Methods
extension AllNumbersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return itemStore.items.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: MyConstants.tableViewCellId, for: indexPath) as! CustomTableViewCell
    let item = itemStore.items[indexPath.row]
    cell.numberLabel.text = String(item.numberValue)
    cell.wordLabel.text = String(item.word)
    if item.hasPicture {
      cell.customImageView.image = UIImage(contentsOfFile: item.pictureURL.path())
    }
    return cell
  }
  
  // in Item - number + image
  // save in one method in diff places
  // validate returns enum - error and valid
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let item = itemStore.items[indexPath.row]
      
      let alertController = {
        let title = "Delete \(item.numberValue)"
        let message = "Are you sure you want to delete this number?"
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        ac.addAction(cancelAction)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
          self.itemStore.removeItem(item)
          self.tableView.deleteRows(at: [indexPath], with: .automatic)
          self.itemStore.saveItems()
        })
        ac.addAction(deleteAction)
        return ac
      }()
      present(alertController, animated: true)
    }
  }
  
  func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    itemStore.saveItems()
  }
  
  func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
    "Remove"
  }
}

// MARK: - Number Change View Delegate Methods
extension AllNumbersViewController: NumberChangeViewControllerDelegate {
  func numberChangeViewControllerChanged(item: Item, image: UIImage?) {
    itemStore.addItem(item)
    itemStore.saveItems()
    tableView.reloadData()
  }
  
//  func numberChangeViewControllerChanged(number: Item, image: UIImage?) {
//    numbersPool.addNumber(number)
//    tableView.reloadData()
//    MyIO.saveNumbers(numbersPool.numbers)
//    if let picture = image {
//      savePicture(picture, to: number.pictureURL)
//    }
//  }
//
//  func savePicture(_ picture: UIImage, to pictureURL: URL ) {
//    if let data = picture.jpegData(compressionQuality: 0.5) {
//      do {
//        try data.write(to: pictureURL, options: .atomic)
//      }
//      catch {
//        print("Error writing file: \(error)")
//      }
//    }
//  }
}

// MARK: - Details View Controller Delegate Methods
extension AllNumbersViewController: DetailsViewControllerDelegate {
  func detailsViewControllerChanged(item: Item, image: UIImage?) {
    itemStore.saveItems()
    tableView.reloadData()
  }
}
