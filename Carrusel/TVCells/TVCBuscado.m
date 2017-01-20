//
//  TVCBuscado.m
//  Cuadros
//
//  Created by Gesfor on 20/01/17.
//  Copyright © 2017 José Cruz Galindo Martínez. All rights reserved.
//

#import "TVCBuscado.h"

@implementation TVCBuscado

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configurar:(NSString *)nombre {
  _nombreBuscado.text = nombre;
}

@end
