//
//  TVCBuscado.h
//  Cuadros
//
//  Created by Gesfor on 20/01/17.
//  Copyright © 2017 José Cruz Galindo Martínez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVCBuscado : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nombreBuscado;

-(void) configurar:(NSString*) nombre;

@end
