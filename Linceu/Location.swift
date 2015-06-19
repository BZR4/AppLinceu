//
//  Location.swift
//  Linceu
//
//  Created by Esdras Bezerra da Silva on 14/06/15.
//  Copyright (c) 2015 Esdras Bezerra da Silva. All rights reserved.
//

import Foundation
import CoreData

class Location: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var crime: String
    @NSManaged var type: String
    @NSManaged var descriptionCrime: String
}
