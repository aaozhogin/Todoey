//
//  Data.swift
//  Todoey
//
//  Created by Aleksandr Ozhogin on 17/10/19.
//  Copyright © 2019 Aleksandr Ozhogin. All rights reserved.
//

import Foundation
import RealmSwift

class Data: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
}



