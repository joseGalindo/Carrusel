//
//  CVCPersonajeSimple.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 03/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Personaje;

@interface CVCPersonajeSimple : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagenPersonaje;
@property (weak, nonatomic) IBOutlet UIImageView *placa;
@property (weak, nonatomic) IBOutlet UILabel *nombrePersona;
@property (weak, nonatomic) IBOutlet UILabel *fechaPersona;

-(void) configurarCelda:(Personaje*) personaje;
-(void) seleccionarPersonaje;
-(void) deseleccionarPersonaje;



@end
