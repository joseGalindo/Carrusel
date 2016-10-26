//
//  Personaje.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Personaje : UIView

// UI
@property (weak, nonatomic) IBOutlet UIImageView *retrato;
@property (weak, nonatomic) IBOutlet UILabel *posicion;

//
-(void) configurarPersonaje:(NSString*) imagen withNumero:(int) numero;
// -(void) configurarPersonaje:(Persona*) persona;


@end
