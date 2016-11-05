//
//  HeaderFecha.h
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeaderFecha : UIView {
    UIView* vista;
}

// UI
@property (weak, nonatomic) IBOutlet UILabel *intervaloFechas;
@property (weak, nonatomic) IBOutlet UILabel *titulo;

// Logic
@property (getter=isSelected) BOOL vistaSelected;

//
+(CGSize) vistaSize;

//
-(void) configurarVista:(NSString*) fecha withTitulo:(NSString*) title;

-(void) seleccionarVista;
-(void) deseleccionarVista;

- (IBAction)vistaPressed:(id)sender;

@end
