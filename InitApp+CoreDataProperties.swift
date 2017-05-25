//
//  InitApp+CoreDataProperties.swift
//  DreamLister
//
//  Created by Kevin on 2017-05-25.
//  Copyright © 2017 Monorail Apps. All rights reserved.
//

import Foundation
import CoreData


extension InitApp {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InitApp> {
        return NSFetchRequest<InitApp>(entityName: "InitApp")
    }

    @NSManaged public var isInit: Bool

}
