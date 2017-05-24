//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Kevin on 2017-05-24.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
