//
//  ItemType+CoreDataClass.swift
//  DreamLister
//
//  Created by Kevin on 2017-05-25.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData


public class ItemType: NSManagedObject {

}

extension ItemType: Comparable {
    public static func <(lhs: ItemType, rhs: ItemType) -> Bool {
        if lhs.type == "Other" {
            return false
        }
        return lhs.type < rhs.type
    }
}
