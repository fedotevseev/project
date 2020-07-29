//
//  StorageManager.swift
//  project
//
//  Created by Федот Евсеев on 27.07.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ product: Product) {
        
        try! realm.write {
            realm.add(product)
        }
    }
    
    static func deleteObject(_ product: Product) {
        
        try! realm.write {
            realm.delete(product)
        }
    }
}
