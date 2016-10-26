//
//  PersonajesProtocol.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//
#import <UIKit/UIKit.h>

#ifndef PersonajesProtocol_h
#define PersonajesProtocol_h

@protocol PersonajeDelegate <NSObject>

/**
 * Metodo para informar a la vista principal que un personaje
 * fue seleccionado y debe de actualizarse.
 * @param nombre Nombre del personaje seleccionado.
 * @param numPer Numero del personaje seleccionado.
 */
-(void) didSelectPersonaje:(NSString*) nombre withNumber:(int) numPer;

// Este sera el método con la base de datos.
//-(void) didSelectPersonaje:(Personaje*) personaje;

@end

#endif /* PersonajesProtocol_h */
