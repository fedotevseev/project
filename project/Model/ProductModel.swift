//
//  ProductModel.swift
//  project
//
//  Created by Федот Евсеев on 27.07.2020.
//  Copyright © 20a20 Федот Евсеев. All rights reserved.
//

import RealmSwift

class Product: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var count: String?
    
    convenience init(name: String, count: String?) {
        self.init()
        self.name = name
        self.count = count
    }
}

