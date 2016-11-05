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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(CGFloat)vistaHeight {
    return 110;
}

-(void)configurarCelda:(Cronologica*) cronologica{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    formater.dateFormat = @"yyyy";
    NSString* fechas = [NSString stringWithFormat:@"%@ - %@",
                        [formater stringFromDate:cronologica.fechaInicio],
                        [formater stringFromDate:cronologica.fechaFin]];
    _intervaloFechas.text = fechas;
    _tituloIntervalo.text = cronologica.descripcion;
    
    _intervaloFechas.layer.shadowColor = [UIColor blackColor].CGColor;
    _intervaloFechas.layer.shadowOffset = CGSizeMake(5, 1);
    _intervaloFechas.layer.shadowRadius = 3;
    _intervaloFechas.layer.shadowOpacity = 0.5;
    _intervaloFechas.layer.shouldRasterize = NO;
}

@end
