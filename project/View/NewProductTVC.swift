//
//  NewProductTVC.swift
//  project
//
//  Created by Федот Евсеев on 27.07.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import UIKit

class NewProductTVC: UITableViewController {
    
    var currentProduct: Product?
    
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var productName: UITextField!
    @IBOutlet var productCount: UITextField!
    @IBOutlet var stepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        productName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        saveButton.isEnabled = false
        
        stepperConfig()
        editScreen()
    }
    
    // MARK: - Table view data source
    func saveObjects() {
        
        let newProduct = Product(name: productName.text!,
                                 count: productCount.text)
        
        
        if currentProduct != nil {
            try! realm.write {
                currentProduct?.name = newProduct.name
                currentProduct?.count = newProduct.count
            }
        } else {
            StorageManager.saveObject(newProduct)
        }
    }
    
    private func editScreen() {
        
        if currentProduct != nil {
        setupNavigationBar()
        title = currentProduct?.name
        
        productName.text = currentProduct?.name
        productCount.text = currentProduct?.count
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                        style: .plain,
                                                        target: nil,
                                                        action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentProduct?.name
        saveButton.isEnabled = true
    }

    func stepperConfig() {
        let stepperMinValue: Int = Int(stepper.minimumValue)
        let productCounts = productCount
        productCounts?.text = String(stepperMinValue)
        
        stepper.value = 1
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        
    }
    
    @IBAction func stepperSelect(_ sender: UIStepper) {
        let stepperValue: Int = Int(stepper.value)
        productCount.text = String(stepperValue)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension NewProductTVC: UITextFieldDelegate {
    
    // Скрываем клавиатуру по нажатию на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if productName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
}