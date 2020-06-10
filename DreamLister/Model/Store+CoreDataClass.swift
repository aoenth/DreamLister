//
//  Store+CoreDataClass.swift
//  DreamLister
//
//  Created by Kevin on 2017-05-25.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData


public class Store: NSManagedObject {

}

extension Store: Comparable {
    public static func <(lhs: Store, rhs: Store) -> Bool {
        lhs.name < rhs.name
    }
}
