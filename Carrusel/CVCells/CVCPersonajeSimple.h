//
//  CVCPersonajeSimple.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 03/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CVCPersonajeSimple : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imagenPersonaje;

-(void) configurarCelda:(NSString*) nombre;
-(void) seleccionarPersonaje;
-(void) deseleccionarPersonaje;

@end
