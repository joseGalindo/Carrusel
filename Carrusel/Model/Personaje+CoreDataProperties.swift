//
//  Personaje+CoreDataProperties.swift
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 01/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

import Foundation
import CoreData


extension Personaje {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Personaje> {
        return NSFetchRequest<Personaje>(entityName: "Personaje");
    }

    @NSManaged public var biografia: String?
    @NSManaged public var fechaDefuncion: NSDate?
    @NSManaged public var fechaNacimiento: NSDate?
    @NSManaged public var imagen: String?
    @NSManaged public var nombre: String?
    @NSManaged public var ordenCronologico: NSDate?
    @NSManaged public var posicion: Int32
    @NSManaged public var sid: Int32
    @NSManaged public var cronologia: Cronologica?

}
