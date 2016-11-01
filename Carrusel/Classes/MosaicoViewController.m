//
//  MosaicoViewController.m
//  Carrusel
//
//  Created by José Cruz Galindo Martínez on 01/11/16.
//  Copyright © 2016 José Cruz Galindo Martínez. All rights reserved.
//

#import "MosaicoViewController.h"

@interface MosaicoViewController ()

@end

@implementation MosaicoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Gradiente
    CAGradientLayer* capaBandera = [[CAGradientLayer alloc] init];
    capaBandera.frame = _fondo.frame;
    capaBandera.colors = [NSArray arrayWithObjects:
                          (id)[UIColor colorWithRed:(7.0/255.0) green:(100.0/255.0) blue:(26.0/255.0) alpha:1].CGColor,
                          (id)[UIColor whiteColor].CGColor,
                          (id)[UIColor colorWithRed:(179.0/255.0) green:0 blue:(16.0/255.0) alpha:1].CGColor, nil];
    capaBandera.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:0.5],
                             [NSNumber numberWithFloat:1.0], nil];
    capaBandera.startPoint = CGPointMake(0, 0.0);
    capaBandera.endPoint = CGPointMake(1.0, 1.0);
    
    
    [_fondo.layer addSublayer:capaBandera];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
