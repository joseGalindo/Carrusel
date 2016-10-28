//
//  DetalleViewController.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Personaje;

@interface DetalleViewController : UIViewController

// UI
@property (weak, nonatomic) IBOutlet UIImageView *imagenPersonaje;
@property (weak, nonatomic) IBOutlet UILabel *nombrePersonaje;
@property (weak, nonatomic) IBOutlet UITextView *biografiaPersonaje;

// Logic
@property (strong, nonatomic) Personaje* personaje;


- (IBAction)cerrar:(id)sender;

@end
