//
//  Personaje.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonajesProtocol.h"

@interface Personaje : UIView {
    int numeroPersonaje;
}

// UI
@property (weak, nonatomic) IBOutlet UIImageView *retrato;
@property (weak, nonatomic) IBOutlet UILabel *posicion;
@property (weak, nonatomic) IBOutlet UIImageView *vistaOpaca;

// Logic
@property (getter=isSelected) BOOL personajeSelected;
@property (weak, nonatomic) id<PersonajeDelegate> delegado;

+(CGSize) vistaSize;

//
-(void) configurarPersonaje:(NSString*) imagen withNumero:(int) numero;
// -(void) configurarPersonaje:(Persona*) persona;

-(void) seleccionarPersonaje;
-(void) deseleccionarPersonaje;

- (IBAction)selectPersonaje:(id)sender;

@end
