//
//  HeaderFecha.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderFecha : UIView

// UI
@property (weak, nonatomic) IBOutlet UILabel *intervaloFechas;
@property (weak, nonatomic) IBOutlet UILabel *titulo;


//
-(void) configurarVista:(NSString*) fecha withTitulo:(NSString*) title;

@end
