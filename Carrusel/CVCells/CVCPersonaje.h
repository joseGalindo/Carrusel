//
//  CVCPersonaje.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Personaje;

@interface CVCPersonaje : UICollectionViewCell

// UI
@property (weak, nonatomic) IBOutlet UIImageView *retrato;
@property (weak, nonatomic) IBOutlet UILabel *numeroIndicador;
@property (weak, nonatomic) IBOutlet UIImageView *vistaOpaca;

+(CGFloat) vistaHeight;

-(void) configurarCeldaPersonaje:(Personaje*) persona;
-(void) seleccionarCelda;
-(void) deseleccionarCelda;

@end
