//
//  Personaje.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 26/10/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "Personaje.h"

@implementation Personaje

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:[self createView]];
    }
    
    return self;
}

-(UIView*) createView {
    UINib* nib = [UINib nibWithNibName:@"Personaje" bundle:nil];
    UIView* vista = (UIView*)[[nib instantiateWithOwner:self options:nil] firstObject];
    return vista;
}

-(void)configurarPersonaje:(NSString *)imagen withNumero:(int)numero {
    _retrato.image = [UIImage imageNamed:imagen];
    _posicion.text = [NSString stringWithFormat:@"%d", numero];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
