//
//  TVCFecha.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Cronologica;

@interface TVCFecha : UITableViewCell

// UI
@property (weak, nonatomic) IBOutlet UILabel *intervaloFechas;
@property (weak, nonatomic) IBOutlet UIImageView *fondo;


+(CGFloat) vistaHeight;

-(void) configurarCelda:(Cronologica*) cronologica;

@end
