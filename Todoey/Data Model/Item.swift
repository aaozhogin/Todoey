//
//  Model.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 12/9/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import Foundation

class Item: Codable {
    var title : String = ""
    var done : Bool = false
}
