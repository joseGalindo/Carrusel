//
//  Cronologica+CoreDataProperties.swift
//  Cuadros
//
//  Created by José Cruz Galindo Martínez on 04/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

import Foundation
import CoreData


extension Cronologica {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cronologica> {
        return NSFetchRequest<Cronologica>(entityName: "Cronologica");
    }

    @NSManaged public var descripcion: String?
    @NSManaged public var fechaFin: NSDate?
    @NSManaged public var fechaInicio: NSDate?
    @NSManaged public var sid: String?
    @NSManaged public var personajes: NSSet?

}

// MARK: Generated accessors for personajes
extension Cronologica {

    @objc(addPersonajesObject:)
    @NSManaged public func addToPersonajes(_ value: Personaje)

    @objc(removePersonajesObject:)
    @NSManaged public func removeFromPersonajes(_ value: Personaje)

    @objc(addPersonajes:)
    @NSManaged public func addToPersonajes(_ values: NSSet)

    @objc(removePersonajes:)
    @NSManaged public func removeFromPersonajes(_ values: NSSet)

}
