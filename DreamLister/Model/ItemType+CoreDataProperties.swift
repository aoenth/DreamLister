//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Kevin on 2017-05-25.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType")
    }

    @NSManaged public var type: String
    @NSManaged public var toItem: Item?

}
