//
//  TVCFecha.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "TVCFecha.h"

@implementation TVCFecha

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+(CGFloat)vistaHeight {
    return 130;
}

-(void)configurarCelda:(NSString *)fecha withTitulo:(NSString *)title {
    _intervaloFechas.text = fecha;
    _tituloIntervalo.text = title;
}

@end
