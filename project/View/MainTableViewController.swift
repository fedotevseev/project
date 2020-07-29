//
//  MainTableViewController.swift
//  project
//
//  Created by Федот Евсеев on 27.07.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    var products: Results<Product>!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        products = realm.objects(Product.self)
        
        tableView.tableFooterView?.backgroundColor = .red
        tableView.tableFooterView = UIView()
        title = "Shop list"
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return products.isEmpty ? 0 : products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell",
                                                 for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]

        cell.productLabel.text = product.name
        cell.productCount.text = product.count

        return cell
    }

    // MARK: - Navigation

    // MARK: Seque Редактирование
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let product = products[indexPath.row]
            let newProductVC = segue.destination as! NewProductTVC
            newProductVC.currentProduct = product
        }
    }
    
    // MARK: Segue Кнопки сохранения
    @IBAction func saveButtonExit(_ seque: UIStoryboardSegue) {
        guard let newProductVC = seque.source as? NewProductTVC else { return }
        
        newProductVC.saveObjects()
        tableView.reloadData()
    }
    
//    MARK: Удаление строки
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {

        let product = products[indexPath.row]

        if editingStyle == .delete {
            StorageManager.deleteObject(product)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
