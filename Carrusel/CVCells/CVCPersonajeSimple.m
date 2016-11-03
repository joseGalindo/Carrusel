//
//  CVCPersonajeSimple.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 03/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "CVCPersonajeSimple.h"

@implementation CVCPersonajeSimple

- (void)awakeFromNib {
    [super awakeFromNib];
 //   _imagenPersonaje.alpha = 0.5;
}

-(void) configurarCelda:(NSString*) nombre {
    _imagenPersonaje.image = [UIImage imageNamed:nombre];
}

-(void) seleccionarPersonaje {
    NSLog(@"personaje alpha = %f", _imagenPersonaje.alpha);
    //[UIView animateWithDuration:0.3 animations:^{
       _imagenPersonaje.alpha = 1.0; 
    //}];
    NSLog(@"after personaje alpha = %f", _imagenPersonaje.alpha);
}

-(void) deseleccionarPersonaje {
    _imagenPersonaje.alpha = 0.5;
}

@end
