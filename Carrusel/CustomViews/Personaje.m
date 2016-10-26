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
        UIView* vista = [self createView];
        vista.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview: vista];
    }
    
    return self;
}

-(UIView*) createView {
    UINib* nib = [UINib nibWithNibName:@"Personaje" bundle:nil];
    UIView* vista = (UIView*)[[nib instantiateWithOwner:self options:nil] firstObject];
    return vista;
}


+(CGSize)vistaSize {
    return CGSizeMake(100.0, 120.0);
}

-(void)configurarPersonaje:(NSString *)imagen withNumero:(int)numero {
    _retrato.image = [UIImage imageNamed:imagen];
    _posicion.text = [NSString stringWithFormat:@"%d", numero];
}

-(void)seleccionarPersonaje {
}

-(void)deseleccionarPersonaje {
}

- (IBAction)selectPersonaje:(id)sender {
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
