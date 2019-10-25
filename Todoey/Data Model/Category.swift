//
//  Category.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 18/10/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    var items = List<Item>()
}
