//
//  CVCPersonajeSimple.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 03/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "CVCPersonajeSimple.h"
#import "Carrusel-Swift.h"

@implementation CVCPersonajeSimple

- (void)awakeFromNib {
    [super awakeFromNib];
}

/*
-(void) configurarCelda:(NSString*) nombre {
    _imagenPersonaje.image = [UIImage imageNamed:nombre];
}
*/

-(void) configurarCelda:(Personaje *)personaje {
    _imagenPersonaje.image = [UIImage imageNamed:personaje.imagen];
    _nombrePersona.text = personaje.nombreCompleto;
    _fechaPersona.text = personaje.periodo;
}

-(void) seleccionarPersonaje {
    [UIView animateWithDuration:0.5 animations:^{
        _imagenPersonaje.alpha = 1.0;
    }];
    
}


-(void) deseleccionarPersonaje {
    _imagenPersonaje.alpha = 0.5;
}

@end
