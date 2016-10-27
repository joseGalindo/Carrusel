//
//  Cronologica+CoreDataProperties.swift
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 27/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

import Foundation
import CoreData


extension Cronologica {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cronologica> {
        return NSFetchRequest<Cronologica>(entityName: "Cronologica");
    }

    @NSManaged public var sid: Int32
    @NSManaged public var fechaInicio: NSDate?
    @NSManaged public var fechaFin: NSDate?
    @NSManaged public var descripcion: String?

}
