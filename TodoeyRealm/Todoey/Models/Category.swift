//
//  Category.swift
//  Todoey
//
//  Created by Bengi Anıl on 22.01.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var isDone: Bool = false
    let items = List<Item>() ///forward relationship
}
