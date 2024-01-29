//
//  Item.swift
//  Todoey
//
//  Created by Bengi Anıl on 22.01.2024.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var isDone: Bool = false
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items") ///reverse/inverse relationship
}
