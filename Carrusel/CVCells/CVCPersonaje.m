//
//  CVCPersonaje.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "CVCPersonaje.h"
#import "Carrusel-Swift.h"

@implementation CVCPersonaje

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(CGFloat)vistaHeight {
    return 120;
}

-(void)configurarCeldaPersonaje:(NSString *)imagen withNumero:(int)numero {
    _retrato.image = [UIImage imageNamed:@"plutarco"];
    _numeroIndicador.text = [NSString stringWithFormat:@"%d", numero];
}

-(void)configurarCeldaPersonaje:(Personaje *)persona {
    _retrato.image = [UIImage imageNamed:persona.imagen];
    _numeroIndicador.text = [NSString stringWithFormat:@"%d", persona.posicion];
    if (persona.seleccionado) {
        _vistaOpaca.hidden = NO;
        _retrato.alpha = 1.0;
    } else {
        _vistaOpaca.hidden = YES;
        _retrato.alpha = 0.3;
    }
}

-(void)seleccionarCelda {
    _vistaOpaca.hidden = NO;
    _retrato.alpha = 1.0;
}

-(void)deseleccionarCelda {
    _vistaOpaca.hidden = YES;
    _retrato.alpha = 0.3;
}


@end
