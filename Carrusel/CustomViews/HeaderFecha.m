//
//  HeaderFecha.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "HeaderFecha.h"

@implementation HeaderFecha


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        vista = [self createView];
        vista.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _intervaloFechas.layer.shadowColor = [UIColor blackColor].CGColor;
        _intervaloFechas.layer.shadowOffset = CGSizeMake(0, 0);
        _intervaloFechas.layer.shadowRadius = 3;
        _intervaloFechas.layer.shadowOpacity = 0.5;
        _intervaloFechas.layer.shouldRasterize = NO;
        
        [self addSubview:vista];
    }
    
    return self;
}

-(UIView*) createView {
    UINib* nib = [UINib nibWithNibName:@"HeaderFecha" bundle:nil];
    UIView* vistaExt = (UIView*)[[nib instantiateWithOwner:self options:nil] firstObject];
    return vistaExt;
}

+(CGSize)vistaSize {
    return CGSizeMake(200.0, 150.0);
}

-(void)configurarVista:(NSString *)fecha withTitulo:(NSString *)title {
    _intervaloFechas.text = fecha;
    _titulo.text = title;
}

-(void)seleccionarVista {
    // 87, 85, 86
    vista.backgroundColor = [UIColor colorWithRed:(87.0 / 255.0)
                                            green:(85.0 / 255.0)
                                             blue:(86.0 / 255.0)
                                            alpha:1.0];
}

-(void)deseleccionarVista {
    vista.backgroundColor = [UIColor clearColor];
}

- (IBAction)vistaPressed:(id)sender {
    if (!_vistaSelected) {
        [self seleccionarVista];
    } else {
        [self deseleccionarVista];
    }
    _vistaSelected = !_vistaSelected;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
