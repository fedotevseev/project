//
//  DateManager.swift
//  project
//
//  Created by Федот Евсеев on 06.08.2020.
//  Copyright © 2020 Федот Евсеев. All rights reserved.
//

import Foundation

let date = Date()
let calendar = Calendar.current

struct CurrentTime {
    var hour = calendar.component(.hour, from: date)
    var hourString: String {
        return "\(hour)"
    }
}

