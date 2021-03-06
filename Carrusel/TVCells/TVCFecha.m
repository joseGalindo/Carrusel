//
//  TVCFecha.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "TVCFecha.h"
#import "Carrusel-Swift.h"

@implementation TVCFecha

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

+(CGFloat)vistaHeight {
    return 80;
}

-(void)configurarCelda:(Cronologica*) cronologica{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy";
    NSString* fechas = [NSString stringWithFormat:@"%@ - %@",
                        [formater stringFromDate:cronologica.fechaInicio],
                        [formater stringFromDate:cronologica.fechaFin]];
    _intervaloFechas.text = fechas;
    _titulo.text = cronologica.descripcion;
    
    _intervaloFechas.layer.shadowColor = [UIColor blackColor].CGColor;
    _intervaloFechas.layer.shadowOffset = CGSizeMake(5, 1);
    _intervaloFechas.layer.shadowRadius = 3;
    _intervaloFechas.layer.shadowOpacity = 0.5;
    _intervaloFechas.layer.shouldRasterize = NO;
    
    if (cronologica.seleccionado) {
        _intervaloFechas.font = [UIFont fontWithName:@"CicleSemi" size:43];
        _intervaloFechas.textColor = [UIColor colorWithRed:0 green:(47.0 / 255.0) blue:(27.0 / 255.0) alpha:1];
    } else {
        _intervaloFechas.font = [UIFont fontWithName:@"CicleSemi" size:30];
        _intervaloFechas.textColor = [UIColor blackColor];
    }
}

@end
