//
//  Personaje+CoreDataProperties.swift
//  Cuadros
//
//  Created by José Cruz Galindo Martínez on 15/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

import Foundation
import CoreData


extension Personaje {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Personaje> {
        return NSFetchRequest<Personaje>(entityName: "Personaje");
    }

    @NSManaged public var apellidoPaterno: String?
    @NSManaged public var biografia: String?
    @NSManaged public var epocaSid: String?
    @NSManaged public var fechaDefuncion: NSDate?
    @NSManaged public var fechaNacimiento: NSDate?
    @NSManaged public var imagen: String?
    @NSManaged public var nombre: String?
    @NSManaged public var ordenCronologico: NSDate?
    @NSManaged public var periodo: String?
    @NSManaged public var posicion: Int32
    @NSManaged public var seleccionado: Bool
    @NSManaged public var sid: Int32
    @NSManaged public var apellidoMaterno: String?
    @NSManaged public var nombreCompleto: String?
    @NSManaged public var cronologia: Cronologica?

}
